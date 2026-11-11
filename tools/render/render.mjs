#!/usr/bin/env node
// Renders every QML file in examples/ with the locally installed Kirigami and
// Breeze, once with the light and once with the dark colour scheme, and writes
// the PNGs to public/renders/. Also refreshes src/data/theme-*.json.
//
//   node tools/render/render.mjs            render examples that changed
//   node tools/render/render.mjs --force    render everything
//   node tools/render/render.mjs card       render examples whose path contains "card"
import { spawn } from 'node:child_process';
import { promises as fs } from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, '../..');
const examplesDir = path.join(root, 'examples');
const outDir = path.join(root, 'public/renders');
const dataDir = path.join(root, 'src/data');

const SCHEMES = {
  light: { colors: '/usr/share/color-schemes/BreezeLight.colors', icons: 'breeze' },
  dark: { colors: '/usr/share/color-schemes/BreezeDark.colors', icons: 'breeze-dark' },
};
// Plasma's default fonts, so text metrics match a stock Plasma desktop.
const FONT_SPEC = '-1,5,400,0,0,0,0,0,0,0,0,0,0,1';
const FONTS = [
  `font=Noto Sans,10,${FONT_SPEC}`,
  `smallestReadableFont=Noto Sans,8,${FONT_SPEC}`,
  `fixed=Hack,10,${FONT_SPEC}`,
].join('\n');
const SCALE = '2'; // render at 2x so screenshots stay sharp on HiDPI displays
const QML = process.env.QML_BIN || 'qml6';

const argv = process.argv.slice(2);
const force = argv.includes('--force');
const filters = argv.filter((a) => !a.startsWith('--'));

async function walk(dir) {
  const out = [];
  for (const entry of await fs.readdir(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...(await walk(full)));
    else if (entry.name.endsWith('.qml') && /^[a-z]/.test(entry.name)) out.push(full);
  }
  return out.sort();
}

/** foundations/colour-sets.qml and page.window.qml → foundations/colour-sets, components/page */
const nameOf = (file) =>
  path.relative(examplesDir, file).replace(/(\.mobile)?(\.window)?\.qml$/, '');

async function makeConfigHome(theme) {
  const dir = await fs.mkdtemp(path.join(os.tmpdir(), `kirigami-render-${theme}-`));
  const colors = await fs.readFile(SCHEMES[theme].colors, 'utf8');
  await fs.writeFile(
    path.join(dir, 'kdeglobals'),
    `${colors}\n[Icons]\nTheme=${SCHEMES[theme].icons}\n\n[General]\n${FONTS}\n`,
  );
  return dir;
}

function run(args, configHome, extraEnv = {}) {
  return new Promise((resolve) => {
    const child = spawn(QML, args, {
      env: {
        ...process.env,
        XDG_CONFIG_HOME: configHome,
        QT_QPA_PLATFORM: 'offscreen',
        QT_QPA_PLATFORMTHEME: 'kde',
        // GPU rendering: Kirigami's shadowed images and shadows need real
        // shaders; the software renderer draws them black or flipped.
        QT_QUICK_BACKEND: 'rhi',
        QSG_RHI_BACKEND: 'opengl',
        QT_QUICK_CONTROLS_STYLE: 'org.kde.desktop',
        QT_SCALE_FACTOR: SCALE,
        QT_FORCE_STDERR_LOGGING: '1',
        LANGUAGE: 'en_US',
        LC_ALL: 'C.UTF-8',
        ...extraEnv,
      },
    });
    let log = '';
    child.stdout.on('data', (d) => (log += d));
    child.stderr.on('data', (d) => (log += d));
    const timer = setTimeout(() => child.kill('SIGKILL'), 30_000);
    child.on('close', (code) => {
      clearTimeout(timer);
      resolve({ code, log });
    });
  });
}

async function isFresh(source, target) {
  if (force) return false;
  try {
    const [s, t] = await Promise.all([fs.stat(source), fs.stat(target)]);
    return t.mtimeMs >= s.mtimeMs;
  } catch {
    return false;
  }
}

async function main() {
  await fs.mkdir(outDir, { recursive: true });
  await fs.mkdir(dataDir, { recursive: true });
  const configHomes = {};
  for (const theme of Object.keys(SCHEMES)) configHomes[theme] = await makeConfigHome(theme);

  // Theme data: real unit and colour values for the foundations pages.
  for (const theme of Object.keys(SCHEMES)) {
    const { log } = await run([path.join(here, 'DumpTheme.qml')], configHomes[theme]);
    const line = log.split('\n').find((l) => l.includes('THEME-JSON'));
    if (!line) throw new Error(`Could not read theme values (${theme}):\n${log}`);
    const json = JSON.parse(line.slice(line.indexOf('THEME-JSON') + 'THEME-JSON'.length));
    await fs.writeFile(path.join(dataDir, `theme-${theme}.json`), JSON.stringify(json, null, 2) + '\n');
  }

  const files = (await walk(examplesDir)).filter(
    (f) => filters.length === 0 || filters.some((x) => f.includes(x)),
  );
  const jobs = [];
  for (const file of files) {
    for (const theme of Object.keys(SCHEMES)) {
      const target = path.join(outDir, `${nameOf(file)}-${theme}.png`);
      jobs.push({ file, theme, target });
    }
  }

  let failed = 0;
  let rendered = 0;
  const worker = async () => {
    for (let job = jobs.shift(); job; job = jobs.shift()) {
      const label = `${nameOf(job.file)} (${job.theme})`;
      if (await isFresh(job.file, job.target)) continue;
      await fs.mkdir(path.dirname(job.target), { recursive: true });
      const { code, log } = await run(
        [path.join(here, 'Runner.qml'), '--', job.file, job.target],
        configHomes[job.theme],
        // *.mobile.window.qml examples are rendered the way a phone shows them.
        job.file.includes('.mobile.') ? { QT_QUICK_CONTROLS_MOBILE: '1' } : {},
      );
      if (code === 0) {
        rendered++;
        console.log(`  ok    ${label}`);
        const warnings = log.split('\n').filter((l) => l.includes(job.file));
        if (warnings.length) console.log(warnings.map((w) => `        ${w}`).join('\n'));
      } else {
        failed++;
        console.error(`  FAIL  ${label}\n${log.trim().split('\n').map((l) => `        ${l}`).join('\n')}`);
      }
    }
  };
  await Promise.all(Array.from({ length: Math.min(4, os.cpus().length) }, worker));

  for (const dir of Object.values(configHomes)) await fs.rm(dir, { recursive: true, force: true });
  console.log(`${rendered} rendered, ${failed} failed, ${files.length * 2 - rendered - failed} up to date`);
  process.exit(failed ? 1 : 0);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
