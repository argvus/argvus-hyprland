---
title: Raccourcis clavier
description: Trouvez les raccourcis fournis par la configuration ARGVUS Hyprland.
---
Ouvrez **Centre de Contrôle → Bureau & Saisie → Raccourcis Clavier**, ou exécutez `argvus control-center keybindings`.

## Ce que fait la page

**Tous les Raccourcis** recherche et regroupe le manifeste des raccourcis actifs. Vous pouvez sélectionner un raccourci, modifier sa combinaison de touches, capturer une nouvelle combinaison, activer ou désactiver un raccourci configurable et restaurer tous les raccourcis depuis l'action de restauration de la page. Un raccourci doit contenir une touche non-modificatrice ; l'éditeur normalise les noms tels que Super/Win, Ctrl, Alt, Maj, flèches, touches de fonction et touches multimédia. `SUPER + Y` ouvre **Centre de Contrôle → Apparence → Fonds d'Écran**.

Les changements officiels de raccourcis sont stockés dans `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`, représentés par `/keyboard_shortcuts` dans le modèle logique ; le fragment Hyprland généré est écrit sous `~/.config/argvus/data/generated/hypr/`. Un raccourci désactivé est représenté par `null`. Les touches sont des clés de configuration anglaises stables, indépendamment de la langue sélectionnée : un ID de manifeste tel que `window.close` correspond à `close_window`, tandis que `window.drag_mouse` correspond à `drag_window__floating_window_only`. L'ancienne section `/hyprland/keybindings` et `keybindings.toml` sont uniquement destinées à la migration. ARGVUS planifie un rechargement de session uniquement lorsque le plan de projection signale un changement réel.

**Créer des Raccourcis** crée un raccourci clavier global indépendamment du manifeste packagé. Fournissez une description, des touches et soit une commande, soit un répartiteur Lua pris en charge (par exemple `window.float` avec des arguments JSON `{"action":"toggle"}`). **Créer** enregistre et applique le raccourci, puis le sélectionne dans **Tous les Raccourcis → Raccourcis Personnalisés**. Annuler ou `Esc` supprime le brouillon. La création et la capture n’exécutent pas la commande.

Les raccourcis personnalisés peuvent être modifiés, activés/désactivés et supprimés avec confirmation. Les conflits avec des raccourcis activés dans le même contexte nécessitent une confirmation de remplacement ; les liaisons protégées ne peuvent pas être remplacées. La restauration des paramètres par défaut officiels conserve les enregistrements personnalisés. Si la restauration entre en conflit avec un raccourci personnalisé actif, modifiez ou désactivez d'abord ce raccourci personnalisé. Les définitions personnalisées sont stockées sous `/hyprland/custom_shortcuts` dans `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Le `data/generated/hypr/custom-shortcuts.lua` généré est chargé avec le chargeur protégé existant ; les enregistrements invalides sont consignés sans interrompre le reste de la configuration. Les échecs d'enregistrement conservent le brouillon ; les échecs d'application signalent que l'enregistrement a été sauvegardé et peut être réessayé.

Exécutez `argvus control-center shortcuts create` ou `argvus control-center shortcuts list` pour ouvrir l'une ou l'autre page. Pour les sous-cartes avancées, les liaisons de souris ou les drapeaux, [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) reste disponible. Ne modifiez jamais les fragments générés.

## Référence actuelle

Le manifeste de base et les fiches de triche installées se trouvent sous `/usr/share/argvus/hyprland/`. La substitution utilisateur active n'est pas un manifeste de remplacement : elle modifie les entrées sélectionnées dans le Centre de Contrôle. C'est pourquoi une liste spécifique à une version et copiée manuellement peut devenir obsolète.

Certain actions intégrées utiles incluent le déplacement du focus et des espaces de travail, l'activation/désactivation des fenêtres flottantes, les captures d'écran et l'enregistrement, l'ouverture du lanceur/terminal, le changement d'apparence, le verrouillage de la session, le contrôle des médias et le rechargement de Hyprland. Les raccourcis par défaut sont listés dans le [tableau des raccourcis par défaut](#default-shortcut-table) ci-dessous ; la page du Centre de Contrôle montre les raccourcis tels qu'ils sont actuellement configurés.

`SUPER + Shift + R` est le rechargement explicite à l'exécution : il recharge Hyprland et redémarre la barre des tâches ARGVUS, le Panneau de Contrôle et les services de Télémétrie des Widgets. Les rechargements basés sur la configuration restent conditionnels et ignorent le rechargement graphique lorsque l'état canonique est inchangé.

## Tableau des raccourcis par défaut

Le tableau liste les raccourcis du manifeste de base (`/usr/share/argvus/hyprland/keybindings.json`) avec leurs touches par défaut. Vos modifications dans le Centre de Contrôle remplacent les touches affichées ici pour les raccourcis concernés, et les raccourcis désactivés ne s'exécutent pas.### Navigation

| Raccourci | Description |
| --- | --- |
| `SUPER + Left Arrow` | Focaliser la fenêtre en mosaïque par direction |
| `SUPER + Right Arrow` | Focaliser la fenêtre en mosaïque par direction |
| `SUPER + Up Arrow` | Focaliser la fenêtre en mosaïque par direction |
| `SUPER + Down Arrow` | Focaliser la fenêtre en mosaïque par direction |
| `SUPER + CTRL + Left Arrow` | Faire défiler le focus entre les fenêtres (en mosaïque et flottantes) |
| `SUPER + CTRL + Right Arrow` | Faire défiler le focus entre les fenêtres (en mosaïque et flottantes) |

### Espaces de travail

| Raccourci | Description |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Se déplacer entre les zones de travail |
| `CTRL + ALT + Left Arrow` | Se déplacer entre les zones de travail |
| `Mouse extra button (mouse:276)` | Se déplacer entre les zones de travail |
| `Mouse side button (mouse:275)` | Se déplacer entre les zones de travail |
| `SUPER + 1` | Espace de travail 1 |
| `SUPER + 2` | Espace de travail 2 |
| `SUPER + 3` | Espace de travail 3 |
| `SUPER + 4` | Espace de travail 4 |
| `SUPER + 5` | Espace de travail 5 |
| `SUPER + 6` | Espace de travail 6 |
| `SUPER + 7` | Espace de travail 7 |
| `SUPER + 8` | Espace de travail 8 |
| `SUPER + 9` | Espace de travail 9 |
| `SUPER + CTRL + 1` à `SUPER + CTRL + 9` | Ouvre le projet à cette position de `argvus projects` |
| `SUPER + Shift + 1` | Déplacer la fenêtre vers le bureau 1 |
| `SUPER + Shift + 2` | Déplacer la fenêtre vers le bureau 2 |
| `SUPER + Shift + 3` | Déplacer la fenêtre vers le bureau 3 |
| `SUPER + Shift + 4` | Déplacer la fenêtre vers le bureau 4 |
| `SUPER + Shift + 5` | Déplacer la fenêtre vers le bureau 5 |
| `SUPER + Shift + 6` | Déplacer la fenêtre vers le bureau 6 |
| `SUPER + Shift + 7` | Déplacer la fenêtre vers le bureau 7 |
| `SUPER + Shift + 8` | Déplacer la fenêtre vers le bureau 8 |
| `SUPER + Shift + 9` | Déplacer la fenêtre vers le bureau 9 |

### Fenêtres

| Raccourci | Description |
| --- | --- |
| `SUPER + S` | Agrandir la fenêtre (basculer) |
| `SUPER + Q` | Fermer la fenêtre |
| `SUPER + Shift + Space` | Activer/Désactiver la fenêtre flottante |
| `SUPER + F` | Fenêtre en plein écran |
| `SUPER + E` | Basculer entre fractionnement vertical/horizontal |
| `SUPER + W` | Grouper/Dégrouper en onglets |
| `SUPER + Tab` | Naviguer entre les onglets |
| `SUPER + Shift + Left Arrow` | Déplacer la fenêtre |
| `SUPER + Shift + Right Arrow` | Déplacer la fenêtre |
| `SUPER + Shift + Up Arrow` | Déplacer la fenêtre |
| `SUPER + Shift + Down Arrow` | Déplacer la fenêtre |
| `SUPER + Left mouse button (mouse:272)` | Déplacer la fenêtre (fenêtre flottante uniquement) |
| `SUPER + Right mouse button (mouse:273)` | Mode redimensionnement de la fenêtre (fenêtre flottante uniquement) |
| `SUPER + R` | Entrer en mode redimensionnement de la fenêtre (fenêtre flottante uniquement) |

### Applications

| Raccourci | Description |
| --- | --- |
| `SUPER + Enter` | Borne |
| `SUPER + [` | Bloc-notes du terminal (menu déroulant sur un espace de travail spécial ; appuyez de nouveau pour cacher) |
| `SUPER + Space` | Gestionnaire de fichiers |
| `SUPER + CTRL + Space` | Moniteur système |
| `SUPER + Shift + D` | Menu des périphériques amovibles |
| `SUPER + Shift + F` | ARGVUS Focus (sessions Pomodoro et de concentration) |
| `SUPER + Shift + C` | ARGVUS Horloge (horloge, minuteurs et alarmes) |
| `SUPER + D` | Lancement de programme |
| `SUPER + B` | Navigateur par défaut |
| `SUPER + C` | Calculatrice |
| `SUPER + ALT + S` | Sélecteur d’hôte SSH (`argvus ssh`) |
| `SUPER + ALT + N` | Sélecteur d’extraits (`argvus snippets`) |
| `SUPER + ALT + G` | Sélecteur de projet, puis TUI git (lazygit ou gitui) dans le projet choisi (`argvus git`) |

### Média

| Raccourci | Description |
| --- | --- |
| `XF86AudioRaiseVolume` | Augmenter le volume |
| `Volume Down` | Baisser le volume |
| `Mute` | Couper le son |
| `Brightness Up` | Augmenter la luminosité |
| `Brightness Down` | Diminuer la luminosité |
| `Play/Pause` | Lecture/Pause |
| `Next Track` | Piste suivante |
| `Previous Track` | Piste précédente |
| `Stop` | Arrêter la piste |

### Captures d'écran et enregistrement

| Raccourci | Description |
| --- | --- |
| `Print` | Capturer la zone sélectionnée |
| `SUPER + Print` | Capturer la fenêtre active |
| `SUPER + Shift + Print` | Capturer tout l'écran |
| `SUPER + G` | Démarrer/Pause/Reprendre l'enregistrement de l'écran |
| `SUPER + Shift + G` | Arrêter et sauvegarder l'enregistrement de l'écran |

### Séance

| Raccourci | Description |
| --- | --- |
| `SUPER + L` | Verrouiller le système |
| `SUPER + escape` | Quitter le système |
| `SUPER + Shift + R` | Recharger Hyprland |
| `SUPER + Shift + S` | Éteindre/Allumer le moniteur (ne pas mettre le système en suspension) |
| `SUPER + Shift + L` | Choisir le délai de verrouillage en cas d’inactivité |
| `SUPER + ALT + W` | Activer/Désactiver le mode Veille |

### Système

| Raccourci | Description |
| --- | --- |
| `SUPER + Shift + /` | Fiches pratiques Hyprland |
| `SUPER + CTRL + /` | Fiches pratiques Kitty |
| `SUPER + F1` | Ouvrir À propos de ARGVUS |
| `SUPER + ALT + C` | Ouvrir le Centre de contrôle |
| `SUPER + P` | Sélecteur de couleur |
| `SUPER + .` | Sélecteur d’emoji |
| `SUPER + H` | Historique du presse-papiers |
| `SUPER + Shift + H` | Effacer l’historique du presse-papiers |

### Widgets

| Raccourci | Description |
| --- | --- |
| `SUPER + ,` | Ouvrir/Fermer la barre latérale de notifications |
| `Middle mouse button (mouse:274)` | Ouvrir/Fermer la barre latérale de notifications |
| `SUPER + Backspace` | Basculer la Waybar en haut |
| `SUPER + Shift + W` | Configurer l'emplacement météo |
| `SUPER + ALT + Up Arrow` | Déplacer la barre des tâches en haut |
| `SUPER + ALT + Down Arrow` | Déplacer la barre des tâches en bas |

### Apparence

| Raccourci | Description |
| --- | --- |
| `SUPER + Y` | Ouvrir le Centre de contrôle des fonds d'écran |
| `SUPER + Shift + T` | Ouvrir le sélecteur de thèmes |
| `SUPER + Shift + M` | Ouvrir le sélecteur de mode Collé/Espacé |
| `SUPER + F5` | Basculer entre les thèmes ARGVUS Dark et ARGVUS Light |
| `SUPER + F6` | Basculer les animations |
| `SUPER + Shift + B` | Ouvrir le sélecteur de luminosité et le basculement du Mode Nuit |

### Mode redimensionnement (après SUPER + R)

Ces raccourcis fonctionnent uniquement lorsque le mode redimensionnement est actif. `Esc` ou `Enter` quitte le mode.

| Raccourci | Description |
| --- | --- |
| `Right Arrow` | Redimensionner |
| `Left Arrow` | Redimensionner |
| `Up Arrow` | Redimensionner |
| `Down Arrow` | Redimensionner |
| `Shift + Right Arrow` | Déplacer la fenêtre |
| `Shift + Left Arrow` | Déplacer la fenêtre |
| `Shift + Up Arrow` | Déplacer la fenêtre |
| `Shift + Down Arrow` | Déplacer la fenêtre |
| `escape` | Quitter le mode redimensionnement |
| `Enter` | Quitter le mode redimensionnement |


Voir [Windows et mise en page](/docs/argvus-hyprland/windows-and-layout/) pour le comportement flottant et des espaces de travail et [Centre de contrôle](/docs/components/argvus-control-center/) pour le flux de travail des paramètres.

## Lumière nocturne

**SUPER + Shift + B** conserve l'action `appearance.brightness` dans le manifeste de raccourcis clavier canonical. Son menu de luminosité Rofi propose également Night Light lorsque Hyprsunset est disponible. Configurez la température (1000–20000 K) et les heures de début/fin locales dans **Centre de Contrôle > Bureau et Entrée > Affichages > Night Light**. L'action rapide utilise l'interface CLI partagée et ne recharge pas Hyprland ni ne modifie le Lua généré.

Avec le paquet optionnel argvus-ai installé, SUPER + A ouvre le menu des agents IA. Le raccourci respecte les remplacements utilisateur app.ai et disparaît après la suppression du paquet et le rechargement du compositeur. Jusqu'au rechargement, l'action protégée est inactive.


Le paquet optionnel argvus-ai possède /usr/share/argvus/ai/hyprland.lua. Hyprland le charge en toute sécurité avant les substitutions de l'utilisateur ; la suppression du module supprime sa liaison lors du rechargement. Le paquet Hyprland fournit un hook Pacman qui ne modifie que l'horodatage de la configuration système après l'installation, la mise à jour ou la suppression du module, déclenchant le rechargement automatique natif. Si le rechargement automatique est désactivé ou si une configuration root utilisateur séparée est utilisée, rechargez explicitement cette configuration. Le catalogue du Centre de Contrôle inclut app.ai avec les mêmes touches par défaut et l'étiquette localisée ; la liaison reste inactive sans le module optionnel.

## Terminal des paquets

Ces touches s'appliquent à l'intérieur de **Centre de Contrôle > Administration du Système > Paquets**, plutôt qu'à Hyprland de manière globale. `F8` rouvre le terminal de transaction, `Esc` le cache sans arrêter le processus, `Shift+PageUp/PageDown` fait défiler l'historique, `Shift+End` revient à la sortie en direct et `Ctrl+C` interrompt l'enfant focalisé. La fiche d'aide installée inclut les mêmes touches.

Dans Paquets, `/` focalise la barre de **Recherche** en haut. `Enter` y soumet les recherches d'installation Official/AUR ; les listes de suppression et de mise à jour se filtrent au fur et à mesure que vous tapez. `Down` se déplace vers les résultats, `Up` sur le premier résultat revient à la Recherche, et `Esc` dans la Recherche préserve la requête et revient à la liste. Entrée sur un résultat exécute son action sur le paquet.
