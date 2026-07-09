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
