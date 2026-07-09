# computelearning

**Le même ordinateur, dans tous les univers.**

On a construit des ordinateurs fonctionnels dans Minecraft, dans Factorio, dans le jeu
de la vie de Conway, avec des dominos. Ce site les réunit et les met en parallèle :
voir *le même circuit* exister dans des univers qui n'ont rien en commun, c'est
comprendre ce qu'est vraiment un ordinateur — une idée, pas un objet.

Le site est organisé comme une **matrice concepts × médias** :

- **Les concepts** : l'échelle qui mène du bit à la machine programmable
  (signal binaire → portes logiques → circuits combinatoires → mémoire → horloge →
  ALU → architecture CPU → programmes).
- **Les médias** : les univers où ce chemin a été parcouru (jeux, simulations,
  objets physiques — et demain BD, cours, approches mathématiques…).
- **Les ressources** : vidéos, wikis, saves, articles qui relient un média à un ou
  plusieurs concepts.

Les cases vides de la matrice sont la todo-list publique du projet.

## Développement

Site statique [Astro](https://astro.build). Tout le contenu vit dans
`src/content/` sous forme de fichiers Markdown/YAML validés par schéma.

```sh
npm install
npm run dev      # serveur local sur localhost:4321
npm run build    # build statique dans ./dist/ (valide aussi tout le contenu)
```

## Contribuer

Ajouter une ressource = ajouter un fichier YAML d'une dizaine de lignes dans
`src/content/resources/`, via une pull request. Voir [CONTRIBUTING.md](CONTRIBUTING.md)
ou la page `/contribuer` du site.

## Licences

- **Code** : [MIT](LICENSE).
- **Contenu éditorial** (fichiers de `src/content/`) :
  [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.fr).
- Les ressources liées (vidéos, wikis, jeux) appartiennent à leurs auteurs respectifs
  et sont uniquement référencées, jamais copiées.
