import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const docs = defineCollection({
  loader: glob({ pattern: '**/*.mdx', base: './src/content/docs' }),
  schema: z.object({
    title: z.string(),
    /** One or two plain sentences: what this is and when you need it. */
    summary: z.string(),
    section: z.enum(['start', 'tutorial', 'foundations', 'patterns', 'components']),
    order: z.number(),
    /** Example (path under examples/, no extension) used as the card image. */
    cover: z.string().optional(),
    /** QML type names this page documents, e.g. ["Kirigami.Card"]. */
    types: z.array(z.string()).default([]),
    /** Upstream pages this page was written from. */
    sources: z.array(z.object({ label: z.string(), url: z.string().url() })).default([]),
  }),
});

export const collections = { docs };
