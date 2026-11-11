import { getCollection, type CollectionEntry } from 'astro:content';

export const SITE = {
  name: 'Kirigami Design Guide',
  tagline: 'A visual guide to designing KDE apps with Kirigami',
  kirigamiVersion: '6.31',
};

export const SECTIONS = [
  { id: 'start', title: 'Start here', blurb: 'What KDE design is about and how to read this guide.' },
  { id: 'foundations', title: 'Foundations', blurb: 'Colour, spacing, type and icons: the rules every screen shares.' },
  { id: 'patterns', title: 'Patterns', blurb: 'How to solve the problems every app has: getting around, showing content, asking, and telling.' },
  { id: 'components', title: 'Components', blurb: 'The building blocks Kirigami gives you, and when to use each.' },
  { id: 'tutorial', title: 'Tutorial: a to-do app', blurb: 'Build a small, complete Kirigami app in seven steps, with the code and a screenshot at each one.' },
] as const;

export type Doc = CollectionEntry<'docs'>;

/** Prefixes a root-relative path with the configured base path. */
export function url(path: string): string {
  const base = import.meta.env.BASE_URL.replace(/\/$/, '');
  return `${base}${path.startsWith('/') ? path : `/${path}`}`;
}

export const docPath = (doc: Doc) => `/${doc.id.replace(/\.mdx$/, '')}/`;

/** All pages in reading order: by section, then by `order`. */
export async function orderedDocs(): Promise<Doc[]> {
  const docs = await getCollection('docs');
  const rank = (d: Doc) => SECTIONS.findIndex((s) => s.id === d.data.section);
  return docs.sort((a, b) => rank(a) - rank(b) || a.data.order - b.data.order);
}
