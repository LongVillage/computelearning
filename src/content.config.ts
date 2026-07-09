import { defineCollection, reference, z } from "astro:content";
import { glob } from "astro/loaders";

/**
 * L'échelle pédagogique : les concepts qui mènent du signal binaire
 * à l'ordinateur complet. `order` définit leur position dans l'échelle.
 */
const concepts = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/concepts" }),
  schema: z.object({
    title: z.string(),
    order: z.number().int().positive(),
    summary: z.string(),
  }),
});

/**
 * Un média = un univers dans lequel on peut construire un ordinateur
 * (jeu vidéo, simulation mathématique, objet physique, cours…).
 * `primitive` : ce qui y joue le rôle de porte logique.
 */
const media = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/media" }),
  schema: z.object({
    title: z.string(),
    type: z.enum([
      "jeu-video",
      "simulation",
      "physique",
      "cours",
      "livre",
      "bd",
      "autre",
    ]),
    primitive: z.string(),
    links: z
      .array(z.object({ label: z.string(), url: z.string().url() }))
      .default([]),
  }),
});

/**
 * Une ressource externe : le cœur du catalogue.
 * Chaque ressource relie un média à un ou plusieurs concepts.
 */
const resources = defineCollection({
  loader: glob({ pattern: "**/*.yaml", base: "./src/content/resources" }),
  schema: z.object({
    title: z.string(),
    medium: reference("media"),
    concepts: z.array(reference("concepts")).min(1),
    type: z.enum(["video", "wiki", "article", "save", "outil", "cours", "jeu"]),
    url: z.string().url(),
    author: z.string(),
    lang: z.string().default("en"),
    license: z.string().optional(),
    notes: z.string().optional(),
  }),
});

export const collections = { concepts, media, resources };
