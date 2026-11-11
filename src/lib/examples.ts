import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();

export interface ExampleInfo {
  /** QML source with the import block kept, as shown to readers. */
  code: string;
  /** Size in CSS pixels (renders are stored at 2x). */
  width: number;
  height: number;
  light: string;
  dark: string;
}

/** Looks up an example by name, e.g. "components/card". */
export function loadExample(name: string): ExampleInfo {
  const candidates = [`${name}.qml`, `${name}.window.qml`, `${name}.mobile.window.qml`].map((f) => path.join(root, 'examples', f));
  const source = candidates.find((f) => fs.existsSync(f));
  if (!source) throw new Error(`Example "${name}" not found in examples/`);

  const png = path.join(root, 'public/renders', `${name}-light.png`);
  if (!fs.existsSync(png)) {
    throw new Error(`Example "${name}" has no render. Run "npm run render".`);
  }
  // PNG stores width and height as big-endian integers at bytes 16 and 20.
  const header = Buffer.alloc(24);
  const fd = fs.openSync(png, 'r');
  fs.readSync(fd, header, 0, 24, 0);
  fs.closeSync(fd);

  return {
    code: fs.readFileSync(source, 'utf8').trim(),
    width: header.readUInt32BE(16) / 2,
    height: header.readUInt32BE(20) / 2,
    light: `/renders/${name}-light.png`,
    dark: `/renders/${name}-dark.png`,
  };
}
