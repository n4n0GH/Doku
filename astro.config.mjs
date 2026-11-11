import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';

// On GitHub Pages a project site lives under /<repo>/. The deploy workflow
// passes both values; locally the site is served from the root.
const site = process.env.SITE_URL || 'http://localhost:4321';
const base = process.env.BASE_PATH || '/';

export default defineConfig({
  site,
  base,
  trailingSlash: 'always',
  integrations: [mdx()],
  markdown: {
    shikiConfig: {
      themes: { light: 'github-light', dark: 'github-dark' },
    },
  },
});
