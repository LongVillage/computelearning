---
title: "La mémoire : les bascules"
order: 4
summary: "Boucler la sortie d'un circuit sur son entrée crée un état stable : la machine se souvient. Bascules, registres, RAM."
---

Un circuit combinatoire oublie tout instantanément. Pour se souvenir, il faut une
**boucle de rétroaction** : deux portes NOR croisées forment un verrou SR, le plus
petit circuit capable de retenir un bit.

De là : bascule D (mémoriser sur commande), registre (plusieurs bits côte à côte),
puis RAM (des registres adressables). Dans chaque média, repérer la mémoire, c'est
repérer où le signal tourne en rond.
