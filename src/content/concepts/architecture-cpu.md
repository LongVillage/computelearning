---
title: "L'architecture d'un CPU"
order: 7
summary: "ALU + registres + mémoire + horloge + une unité de contrôle qui lit des instructions : le cycle fetch-decode-execute, et la machine devient programmable."
---

Assembler tous les étages précédents autour d'une **unité de contrôle** donne un
processeur : à chaque cycle, il **lit** une instruction en mémoire (fetch), la
**décode**, l'**exécute** (via l'ALU et les registres), puis passe à la suivante.

L'idée décisive — l'architecture de von Neumann — est que **les instructions sont
elles-mêmes des données en mémoire**. La machine n'est plus câblée pour une tâche :
elle exécute ce qu'on écrit dans sa mémoire. C'est la définition d'un ordinateur.
