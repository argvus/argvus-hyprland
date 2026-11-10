---
title: Fenêtres et disposition
description: Comprendre les écarts, les frontières, les modes et l'espace des panneaux dans ARGVUS.
---
ARGVUS utilise Hyprland pour le placement des fenêtres en mosaïque et flottantes. Les commandes de disposition accessibles par l'utilisateur se trouvent dans trois pages du Centre de Contrôle : **Centre de Contrôle → Apparence → Barre des tâches** (position, espaces et icônes), **Centre de Contrôle → Bureau & Saisie → Hyprland → Fenêtres → Espaces** et **Centre de Contrôle → Bureau & Saisie → Hyprland → Bordures**.

## Les concepts

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```
- **Espaces entre fenêtres** sont les espaces entre les fenêtres en mosaïque et le bord extérieur de la disposition en mosaïque.
- **Espacement de la barre des tâches ou du shell** est la marge autour des surfaces du bureau telles que la barre des tâches et le panneau. Ce n'est pas la même valeur que l'espace entre fenêtres.
- **Bordures** sont le contour visible tracé autour d'une fenêtre. **Épaisseur du bord** contrôle la largeur de la bordure exposée par la page d'apparence.
- **Arrondis** font partie du mode visuel sélectionné. Ils changent la forme des coins de la fenêtre plutôt que de déplacer la fenêtre.
- **Réservation du panneau et marge visible** sont des préoccupations distinctes : un panneau peut occuper ou utiliser visiblement de l'espace tandis que Hyprland dispose encore les fenêtres selon l'état d'espacement actif.

## Modes collant et espacé

Les modes de thème inclus fournissent deux géométries de départ :

| Mode | Comportement de la fenêtre | Traitement de la surface |
| --- | --- | --- |
| Collant | Espace interne `2`, espace externe `0` par défaut | Carré, compact et proche du bord de l'écran |
| Espacé | Espace interne `10`, espace externe `18` par défaut | Arrondi, ombré et plus spacieux ; la marge de la barre des tâches/shell par défaut est `18` |

Ce sont des valeurs par défaut, pas des limites. Les pages Espaces des fenêtres et Espaces de la barre des tâches peuvent stocker indépendamment les espaces des fenêtres et les marges de la barre des tâches. Changer un thème ou un mode peut projeter différentes valeurs de mise en page effectives.

## Contrôles de mise en page

Chaque contrôle est indépendant et se trouve sur la page indiquée ici :

- **Barre des tâches → Position** — position de la barre des tâches, bord supérieur ou inférieur.
- **Barre des tâches → Espaces** — marges de la barre des tâches en haut, à gauche, à droite et en bas, chacune de `0` à `100`. Sticky fixe par défaut la marge inférieure à `2` ; Espacée utilise `18`.
- **Barre des tâches → Icônes** — si le groupe d'utilitaires de la barre des tâches utilise un comportement automatique ou toujours développé.
- **Hyprland → Fenêtres → Espaces** — espace intérieur et espaces extérieurs en haut/gauche/droite/bas, chacun de `0` à `100`.
- **Hyprland → Bordures** — bordures générales : activer les coins arrondis ; lorsqu'activés, l'arrondi est sélectionnable de `2` à `10`. L'épaisseur des bords est également définie ici, de `0` à `10`.
- **Hyprland → Bordures → Ombre** — l'ombre de la fenêtre, désactivée par défaut. Elle définit la plage, la puissance de rendu, les coins nets, les décalages et l'échelle, et sa couleur suit l'accent du thème avec alpha `99` sauf si une couleur est saisie.

Ces valeurs sont écrites dans l'état d'apparence d'ARGVUS, et `argvus-config` les projette dans les fichiers générés par Hyprland, que la session applique ensuite. Une marge de barre des tâches modifie la position de la surface du shell ; un écart extérieur de fenêtre modifie la zone des fenêtres en mosaïque. Ils peuvent produire une distance visuelle similaire, mais modifier l'un ne change pas l'autre.

## Fenêtres et espaces de travail

Les fenêtres en mosaïque sont disposées par Hyprland sur l'espace de travail actif. ARGVUS prend également en charge les fenêtres utilitaires flottantes ; `SUPER + SHIFT + Space` bascule la fenêtre focalisée entre les dispositions en mosaïque et flottantes. Le déplacement des espaces de travail et la mise au point des fenêtres sont contrôlés par le manifeste des raccourcis clavier actif ; voir [Raccourcis clavier](/docs/argvus-hyprland/keyboard-shortcuts/).

La configuration packagée ouvre le Centre de Contrôle, Snake et l'Analyseur d'Utilisation du Disque en fenêtres flottantes et centrées. L'Analyseur d'Utilisation du Disque utilise la même géométrie initiale `1399 × 920` que la fenêtre contextuelle de mémoire de la barre des tâches, appliquée par sa règle de classe de fenêtre lors de l'ouverture de la fenêtre. ARGVUS Focus et ARGVUS Clock sont des fenêtres contextuelles GTK layer-shell ancrées à côté de la barre des tâches, elles ne sont donc pas des fenêtres en mosaïque et n'utilisent pas les règles de fenêtre Hyprland. La carte d'alarme de l'horloge est une surface de couche séparée (`argvus-clock-alarm`).

Le Panneau de Contrôle utilise une surface de couche plein écran pendant que son modal est ouvert. Les règles packagées flottent, centrent et épinglent les fenêtres de l'agent Polkit, du portail GTK et de KDialog afin que les dialogues lancés par le panneau restent au-dessus du modal et puissent recevoir des entrées.

`hyprpicker`, ouvert avec `SUPER + P`, n'utilise pas les animations Hyprland. Cette exception concerne uniquement le sélecteur de couleurs ; les autres animations continuent à suivre les paramètres globaux.

### Placement des espaces de travail pour les navigateurs et les IDE

Aucune règle de fenêtre n'est définie par défaut sur une installation vierge. Vous pouvez ajouter vos propres règles de placement d'espace de travail par application sous `hyprland.window_rules` dans `argvus-config`, par exemple :

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```
Chaque règle a un `workspace` de 1 à 10 et une liste `classes`. Les entrées de `classes` sont des expressions régulières correspondant à la classe de fenêtre (sensible à la casse), par exemple `[Cc]ode.*` ou `jetbrains-.*`. Seules les lettres, chiffres et `._*+?-[]()|^$` sont acceptés. `argvus-config` écrit les règles dans `generated/hypr/window-rules.lua`, que la configuration de Hyprland charge. Pour remplacer les règles sans changer les valeurs par défaut, ajoutez des appels `hl.window_rule` à `rules.lua` dans votre répertoire de données ARGVUS ; ceux-ci se chargent après les règles générées.

## Ce qu'il faut changer en premier

- Si les fenêtres semblent encombrées, augmentez l'espacement des fenêtres ou utilisez le mode Espacé.  
- Si les fenêtres semblent trop éloignées du bord de l'écran, réduisez l'espacement extérieur/de la barre des tâches ou utilisez le mode Collant.  
- Si la barre des tâches apparaît mal alignée après avoir changé sa position, vérifiez la position de la barre des tâches et les quatre marges de la barre des tâches/shell ensemble.  
- Si les fenêtres chevauchent un panneau visuel, vérifiez les paramètres de disposition du panneau et de la barre des tâches avant de modifier les espaces entre les fenêtres.  

Les modifications sont appliquées via l'intégration apparence/session d'ARGVUS. Utilisez l'action de réinitialisation de la page lorsque disponible ; ne modifiez pas directement les fichiers Hyprland générés.  

## Connexe

- [Appearance](/docs/user-guide/appearance/)  
- [Themes](/docs/user-guide/appearance/)  
- [Taskbar](/docs/argvus-taskbar/taskbar/)  
- [Panneau de Contrôle](/docs/argvus-control-panel/)  

## Oscillation des fenêtres

Ouvrez **Bureau & Entrée → Hyprland → Animations → Fenêtres** et utilisez les contrôles  
**Oscillation**. Recherchez `wobble`, ou ouvrez la page directement :

```sh
argvus control-center hyprland animations windows
```
Le Wobble est désactivé par défaut. Ses valeurs par défaut ARGVUS sont rigidité `100`, amortissement `10`, masse `1`, intensité `1` et résolution de maillage `8`. La rigidité et la masse acceptent `0.0001–1000`, l'amortissement `0–1000`, l'intensité `0–2` et le maillage un entier `2–32`. Une résolution de maillage plus élevée augmente le coût de rendu. Utilisez les touches fléchées pour ajuster les valeurs ou Entrée pour les saisir. **Restaurer les valeurs par défaut du Wobble** modifie le brouillon ; **Appliquer** enregistre toutes les modifications d'animation en attente et recharge Hyprland une fois, sans redémarrer la session. Revenir dans Animations conserve le brouillon partagé.

L'interrupteur global Animations supprime le Wobble tout en conservant ses paramètres individuels. Les valeurs canoniques se trouvent sous `effects.wobble_*` dans l'état ARGVUS ; `hypr/state.lua` est généré et ne doit pas être édité manuellement.

Cela nécessite Hyprland **0.57.0 ou plus récent**, imposé par la dépendance de package de `argvus-hyprland`. La version 0.56 n'est pas prise en charge pour cette configuration. L'intensité maximale suit la source du [0.57.0 publié ](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp), qui la limite à `2`, même si une documentation plus récente peut indiquer `3`.

## Mode fenêtre globale

Ouvrez **Panneau de configuration → Bureau & Entrée → Hyprland → Fenêtres → Mode** et sélectionnez **Fenêtres en mosaïque (Par défaut)** ou **Fenêtres flottantes**. Le même sélecteur est disponible depuis l'icône du mode fenêtre dans le groupe d'utilitaires de la barre des tâches.

La préférence s'applique à chaque moniteur et espace de travail et est mémorisée après la déconnexion. Le mode flottant convertit les fenêtres d'application existantes et les nouvelles fenêtres ouvertes. Le mode mosaïque ne restaure que les fenêtres que cette politique a converties ; les dialogues et autres fenêtres déjà flottantes restent flottants. Une fenêtre épinglée explicitement pendant que le mode flottant est actif reste également flottante afin de préserver son épinglage. La disposition en mosaïque est recalculée ; son arbre de division exact précédent n'est pas restauré.

`SUPER + SHIFT + Space` garde son comportement normal par fenêtre en mode mosaïque. En mode flottant, il ne repasse pas une fenêtre en mosaïque. Les panneaux, la barre des tâches et les notifications sont des surfaces layer-shell et ne sont pas affectés. Le plein écran continue d'utiliser le comportement normal de Hyprland ; la maximisation ARGVUS préserve les marges dans Spaced.

La préférence canonique est `/hyprland/window_mode` dans `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Sa projection générée est `data/generated/hypr/window-mode.lua` ; ne la modifiez pas. Le registre de restauration par fenêtre se trouve sous `$XDG_RUNTIME_DIR/argvus`, limité à l’instance du compositeur, et survit aux rechargements de configuration. Il n’est pas réutilisé dans une nouvelle session.

Si l’application est en attente ou échoue, l’interface distingue cela de la préférence enregistrée. Sélectionnez à nouveau l’option pour réessayer. Sans compositeur, la préférence est enregistrée pour la prochaine connexion.

## Boutons de fenêtre et barre d’application

Le mode flottant ajoute une barre de titre ARGVUS avec **Réduire**, **Agrandir / Restaurer** et **Fermer** aux fenêtres d’application normales. Un double-clic sur la barre de titre bascule la maximisation. La décoration supplémentaire est cachée en mode Mosaïque et plein écran. Les applications qui dessinent leurs propres contrôles peuvent afficher les deux barres ; les contrôles ARGVUS uniformes sont intentionnels.

Une deuxième Waybar apparaît sur chaque moniteur, du côté opposé à la barre des tâches principale. Elle liste uniquement les fenêtres de l’espace de travail actuel de ce moniteur, y compris ses fenêtres minimisées. Les onglets de groupe cachés ne créent pas d’entrées supplémentaires. Les entrées minimisées conservent leur association originale avec le moniteur/l’espace de travail. Cliquez sur une fenêtre inactive pour l’activer, sur une fenêtre active pour la minimiser, ou sur une fenêtre minimisée pour la restaurer ; son menu contextuel offre restaurer, minimiser, maximiser/restaurer et fermer. Les icônes d’application inconnues sont remplacées par un symbole de fenêtre. L’activation ou la restauration d’une entrée préserve la position du pointeur. La barre secondaire utilise le CSS principal effectif (couleurs, polices, bordure et arrondis), avec sa hauteur et des marges reflétées sur le bord opposé.

`SUPER + Alt + Up` place la barre principale en haut et la barre de fenêtre en bas. `SUPER + Alt + Down` fait le contraire. Répéter une direction laisse les positions inchangées. Tile n'a que la barre principale. Revenir à Tile restaure toutes les fenêtres minimisées avant de supprimer la barre de fenêtre, puis préserve la politique originale de mosaïque/flottant.

La minimisation utilise l’espace de travail réservé `special:argvus-minimized`. N’utilisez pas cet espace de travail manuellement. Le processus `argvus windows service` enregistre l’identité, l’espace de travail/moniteur d’origine, la géométrie, l’état plein écran/maximisé et l’état d’épinglage dans un registre d’exécution spécifique à l’instance du compositeur sous `$XDG_RUNTIME_DIR/argvus`. Les enregistrements survivent à un redémarrage du service ou à un rechargement de configuration, mais ne traversent pas les sessions de compositeur. La fermeture d’une fenêtre supprime son enregistrement. Si un moniteur disparaît, la restauration utilise une sortie disponible. Une barre de récupération manquante ou défaillante empêche de nouvelles minimisations ; la restauration échouée conserve l’enregistrement et la barre de récupération.

La session possède `argvus-windows.service` et `argvus-window-bar.service`. Ce dernier garde son enfant Waybar dormant dans Tile. Le plugin hyprbars est fourni par `argvus-hyprland`, construit pour l’ABI Hyprland 0.57.0 sur x86_64 ; il n’est pas compilé dans le répertoire personnel de l’utilisateur. Reconstruisez le plugin avec une mise à jour de l’ABI du compositeur.Commandes : `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` et `minimize|restore|activate|maximize|close ADDRESS`. Les adresses des fenêtres proviennent de la liste. `position top --persist` stocke/projette la préférence sans redémarrer la barre principale. Les détails de configuration et d'erreurs d'exécution sont écrits dans le journal ; les échecs d'action visibles affichent également une notification traduite.

En **Espacé + Flottant**, les fenêtres respectent les marges extérieures et les zones réservées par les deux barres. Les limites incluent la bordure et le titre, qui se situe à l'intérieur de la même bordure de fenêtre. La maximisation via les contrôles ARGVUS remplit cette zone avec des marges ; la restauration récupère la géométrie précédente, y compris après le redémarrage d'un service. Le plein écran utilise toujours toute la sortie. Les fenêtres flottantes peuvent se chevaucher ; les interstices internes du carrelage ne les séparent pas.

`SUPER + Alt + Space` bascule le mode tuile/flottant global, en utilisant la même préférence que la barre des tâches et le Centre de contrôle. La commande équivalente est `argvus config window-mode toggle`. Les invocations concurrentes sont sérialisées ; le basculement utilise la préférence enregistrée même lorsque l'application est en attente. Le raccourci peut être modifié ou désactivé dans les Raccourcis clavier ; `SUPER + Shift + Space` conserve son action pour une fenêtre individuelle.
