# Idées pour le futur

Notées dans l'ordre où elles sont venues (2026-07-09). Ce document est un parking,
pas un engagement : rien ici n'est dans la roadmap tant que ce n'est pas devenu une
tranche dans `tasks/roadmap-globale.md`.

## 1. Multiplier les médias (l'horizontal, toujours)

Le cœur du projet : tout univers où l'on peut construire une porte logique a sa
place. Candidats identifiés : électronique réelle (Ben Eater), NandGame,
nand2tetris, Logic World, circuits hydrauliques/pneumatiques, cartes perforées…

## 2. Héberger des mondes et des saves

Aller au-delà du lien : donner accès à une save / un monde téléchargeable.
Idéalement des mondes construits *pour* le site, pédagogiques, qui présentent les
concepts en progression. Julien construira lui-même un monde Minecraft de ce type.
Étape par étape — seulement si des gens le font spécifiquement pour le site.

## 3. Étendre les types de médias au-delà des jeux

Le concept n'est pas « jeux » mais « médias » : BD, cours audio, cours
d'université, approches par les maths. Tout ce qui constitue une *façon
différente* d'expliquer un ordinateur.

## 4. Accompagnement IA pas-à-pas

Un programme via IA qui t'accompagne pour construire l'ordinateur à la main, en
s'assurant que tu comprends chaque étape avant la suivante.

## 5. La recherche par méthode

L'interface finale : taper un média ou une méthode dans une barre de recherche →
accéder au cours à travers cette méthode. (La matrice actuelle est la version
statique de cette idée : une colonne = un cours par méthode.)

## 6. Simulations interactives dans le navigateur

Un jeu de la vie jouable dans la page montrant un glider traverser une porte AND,
un simulateur de circuits logiques. Gros différenciateur pédagogique, gros effort.
L'architecture (islands Astro) le permet sans refonte.

## 7. Hébergement Scaleway

Self-host : Terraform, CI/CD, le site servi depuis notre infra. Chantier séparé,
trivial tant que le site est statique (Object Storage + CDN ou nginx).

## 8. Version anglaise

Reach maximal, cohérent avec les ressources liées. Après que le contenu FR a une
masse critique — le bilinguisme double le coût de chaque contenu.

## 9. La vision ultime : le méta-apprentissage

Un site de méta-apprentissage généraliste. On n'explique rien nous-mêmes : on est
le centre de ce que les gens considèrent comme apprendre, on comprend la « méta »
(au sens gaming : les approches qui marchent) et on propose la bonne méthode à la
bonne personne. Des tutos pour tout, où tous se retrouvent pour partager ou
apprendre. « L'ordinateur » n'est que le premier sujet : le modèle
concepts × médias × ressources se généralise en ajoutant un niveau « sujet ».

Garde-fous décidés en discussion :
- **Auto-sélection par affinité, jamais de profilage psychologique** (les « styles
  d'apprentissage » sont du pop-psych démonté) : la personne choisit l'univers
  qu'elle aime déjà, on ne modélise pas la personne.
- **Généraliser seulement après un deuxième vertical réussi** — un point ne fait
  pas une droite.
- La valeur au départ = le jugement éditorial (quelle ressource mérite sa case),
  pas l'exhaustivité.

## 10. Les signaux et données de la méta

Prolongement de l'idée 9, consigné le 2026-07-09.

### Le vote rare

Un vote **par personne et par domaine**, non transférable et qu'on ne pourra pas
redonner ailleurs plus tard : « le média qui m'a fait comprendre ». Un signal
coûteux/rare est plus difficile à falsifier et porte plus d'information
(signalement coûteux). Par domaine, la donnée est propre : pour chaque personne
et chaque sujet, un seul média élu comme celui du déclic — le match
personne↔méthode en version mesurable.

**Couplage à ne jamais oublier** : la rareté crée l'incitation au farming. Plus
le vote est rare, plus il vaut cher pour celui qui le reçoit, plus les bots
deviennent économiquement rationnels. La parade est dans le *design*, pas dans
la modération après coup : faire que le vote ait de la valeur pour le **votant**
(expression, identité) et non pour le **receveur** — ne pas le brancher
directement sur le ranking ni la rémunération. Un vote qui ne rapporte rien à
booster n'attire pas de bots. Décision de design à trancher le jour venu.

### Le temps jusqu'au déclic

La durée brute d'une ressource est un fruit ambigu (une vidéo de 20 min vs
40 h de Factorio = pommes et oranges). La stat de valeur est la comparaison
inter-types : « certains ont eu le déclic en 10 minutes de BD, d'autres en
40 heures de jeu — les deux sont valides ». C'est une méta-donnée qui renforce
la thèse du site. Trace POC déjà posée : champ `duration` optionnel (minutes)
dans le schéma des ressources.

### La forme des matrices par domaine

Les futurs domaines (informatique quantique, mécanique, logique…) auront chacun
leur propre forme de matrice : des domaines riches en jeux, d'autres pauvres ;
des domaines dominés par la vidéo, d'autres par le papier. La « jouabilité »
d'un domaine est une méta-donnée en soi — elle dit quelque chose de sa nature.
