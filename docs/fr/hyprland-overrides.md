---
title: Remplacements Hyprland
description: Personnalisez la configuration ARGVUS Hyprland sans modifier les fichiers fournis.
---
ARGVUS prend en charge deux manières différentes de personnaliser Hyprland. Il ne faut pas les confondre :

- `~/.config/hypr/hyprland.lua` est une configuration utilisateur complète. Lorsqu'elle est valide et qu'elle n'est pas le modèle Hyprland par défaut, `argvus start` lance Hyprland avec ce fichier au lieu de la configuration fournie.
- `~/.config/argvus/data/hypr/` contient des remplacements ARGVUS incrémentiels. La configuration fournie reste la base et charge ces fragments à la fin.

Pour la plupart des personnalisations, utilisez les remplacements ARGVUS incrémentiels. Ils conservent les valeurs par défaut d'ARGVUS, l'état généré et l'intégration de session disponibles lors des mises à jour du package.

## Fichiers de remplacement pris en charge

Créez le répertoire avant d'ajouter un fragment :

```sh
mkdir -p ~/.config/argvus/data/hypr
```
La configuration empaquetée charge ces fichiers dans cet ordre lorsqu'ils existent :

```text
~/.config/argvus/data/hypr/monitors.lua
~/.config/argvus/data/hypr/rules.lua
~/.config/argvus/data/hypr/bindings.lua
~/.config/argvus/data/hypr/user.lua
```
Utilisez les fichiers par responsabilité :

- `monitors.lua` — déclarations supplémentaires ou de remplacement du moniteur.
- `rules.lua` — règles de fenêtre et de calque.
- `bindings.lua` — raccourcis supplémentaires ou actions personnalisées.
- `user.lua` — variables d'environnement et autres configurations Lua qui ne correspondent pas aux catégories précédentes.

Un fragment contenant une erreur Lua n'arrête pas le reste de la configuration. Hyprland ignore ce fichier, signale `ARGVUS: ignoring invalid user override` avec son chemin et l'erreur, et charge toujours les fragments restants. Vérifiez un fragment avec `luac -p` avant de recharger.

Ne modifiez pas `/usr/share/argvus/hyprland/config/hyprland.lua`. Il est la propriété du paquet et peut être remplacé par une mise à jour.

## Substitutions d'environnement

Utilisez `user.lua` pour les valeurs d'environnement de la session :

```lua
-- ~/.config/argvus/data/hypr/user.lua
hl.env("MY_VARIABLE", "1")
```
Les changements d'environnement affectent les applications lancées par la session. Déconnectez-vous et reconnectez-vous lorsque la valeur doit être héritée par l'ensemble de la session ; un simple rechargement du compositeur ne suffit pas pour les applications déjà démarrées.

ARGVUS possède `XDG_CONFIG_DIRS` et le reconstruit à chaque rechargement de Hyprland, y compris les rechargements déclenchés par des changements de thème. Chaque répertoire de configuration ARGVUS apparaît une seule fois, et les entrées héritées de la session sont conservées après elles sans répétition, de sorte que la valeur reste limitée. Les sessions démarrées par des versions antérieures peuvent encore contenir des entrées dupliquées ; si Kitty, `argvus terminal` ou `argvus --control-center` échouent avec `Out of buffer space calling sprintf`, déconnectez-vous et reconnectez-vous pour démarrer avec un environnement propre.

## Ajout d'un raccourci clavier

Utilisez `bindings.lua` pour un nouveau raccourci qui ne fait pas partie du manifeste des raccourcis clavier ARGVUS :

```lua
-- ~/.config/argvus/data/hypr/bindings.lua
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty"))
```
Utilisez les assistants de répartition Lua ARGVUS pour les actions du compositeur :

```lua
-- Focus the next window with a custom shortcut.
hl.bind("SUPER + CTRL + Tab", hl.dsp.group.next())
```
La liaison est évaluée en même temps que la configuration packagée. Vérifiez les conflits avec les raccourcis existants avant de choisir une combinaison. Conservez les options appropriées lors de la définition de liaisons spéciales, par exemple :

```lua
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)
```
Le Centre de contrôle est le moyen préféré pour modifier ou désactiver une liaison ARGVUS existante :

```sh
argvus control-center keybindings
```
Ces changements sont stockés de manière canonique sous `/keyboard_shortcuts` et matérialisés dans `~/.config/argvus/data/generated/hypr/keybindings.lua`. Une liaison créée manuellement dans `bindings.lua` n'est pas ajoutée au manifeste du Centre de Contrôle et n'est pas gérée par son action de restauration.

## Configuration Hyprland native complète

`~/.config/hypr/hyprland.lua` n'est pas un fichier superposé. Si vous le créez, `argvus start` le valide et l'utilise comme configuration complète de Hyprland :

```sh
mkdir -p ~/.config/hypr
cp /usr/share/argvus/hyprland/config/hyprland.lua ~/.config/hypr/hyprland.lua
```
Cette approche offre un contrôle total, mais le fichier copié devient de votre responsabilité. Il peut devenir obsolète à mesure que ARGVUS change, et un fichier personnalisé qui omet le chargeur ou la gestion de l'état généré d'ARGVUS peut perdre l'intégration avec ARGVUS. Préférez les fichiers de fragments ci-dessus sauf si vous avez l'intention de créer un remplacement complet.

Le fichier Hyprland standard contenant `AUTOGENERATED HYPRLAND CONFIG` est ignoré par `argvus start`, donc sa présence ne remplace pas la configuration ARGVUS. Un fichier utilisateur personnalisé est sélectionné uniquement après validation ; si la validation échoue, le lanceur revient au fichier fourni avec le paquet.

## Appliquer et dépanner

Après avoir modifié un fragment Lua, rechargez la configuration de la session :

```sh
argvus sessionctl reload
```
Validez un fichier Lua complet avant de vous reconnecter :

```sh
luac -p ~/.config/hypr/hyprland.lua
Hyprland --verify-config --config ~/.config/hypr/hyprland.lua
```
Si la configuration de l'utilisateur est rejetée lors du démarrage, inspectez :

```sh
grep -E "Hyprland Lua config|failed validation|using user Lua|fallback" \
  ~/.local/state/argvus/session.log
```
Les sources et assistants emballés se trouvent sous `/usr/share/argvus/hyprland/`. Les fichiers générés sous `~/.config/argvus/data/generated/` sont des états dérivés ; modifiez le paramètre propriétaire ou le fragment de substitution au lieu de modifier directement la sortie générée.

Voir [Raccourcis clavier](/docs/argvus-hyprland/keyboard-shortcuts/) pour le flux de travail du Centre de contrôle et [emplacements de fichiers](/docs/reference/file-locations/) pour la référence complète du chemin de configuration.

La puissance de rendu des ombres est limitée à 1–4 (par défaut 4) avant d'appeler Hyprland, y compris pour les projections d'effets hérités. Cela empêche les valeurs acceptées par les anciennes versions d'ARGVUS de bloquer le démarrage sur Hyprland 0.57.
