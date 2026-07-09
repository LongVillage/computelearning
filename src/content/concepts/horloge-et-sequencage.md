---
title: "L'horloge et le séquençage"
order: 5
summary: "Un battement régulier synchronise tous les circuits : sans horloge, pas d'étapes ; sans étapes, pas de programme."
---

Les circuits réels ont des délais de propagation : sans coordination, les signaux
arrivent dans le désordre. L'**horloge** impose un tempo — à chaque tic, les
registres capturent leurs entrées, et le circuit avance d'une étape bien définie.

C'est ce qui transforme un calcul figé en **processus** : faire une chose, puis la
suivante. La fréquence d'horloge (1 Hz pour les gros CPU Minecraft, des GHz pour le
silicium) ne change rien au principe, seulement à la vitesse.
