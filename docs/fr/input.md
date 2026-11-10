---
title: Souris et pavé tactile
description: Configurer le comportement du pointeur et du pavé tactile dans ARGVUS.
---
Ouvrez **Centre de Contrôle → Langue et Région → Souris & Pavé Tactile**, ou exécutez `argvus control-center input`.

## Souris

Lorsque qu'une souris est détectée, la page affiche :

- sensibilité de `-1.0` à `1.0` ;
- profil d'accélération adaptatif ou fixe ;
- facteur de défilement de `0.1` à `10.0` ;
- défilement naturel ;
- disposition des boutons pour gauchers.

La sensibilité, le facteur de défilement et les commutateurs s'appliquent dans Hyprland tant que la page est ouverte, puis l'état complet des entrées est enregistré. La page lit la valeur actuelle du compositeur lorsqu'aucun fichier d'entrée ARGVUS n'existe.

## Pavé tactile

Lorsque qu'un pavé tactile est détecté, la page affiche le défilement naturel, le tapotement pour cliquer, le tapotement et le glissement, le clic droit à deux doigts et la désactivation lors de la frappe. Ces options ne sont présentées comme contrôles utiles que lorsque la session en cours signale un pavé tactile.

## Contrôles dépendant du matériel

Les commandes de souris avancées prises en charge par `ratbag` sont affichées uniquement pour les appareils compatibles. ARGVUS ne garantit pas que chaque souris supporte les modifications de DPI, de profils ou de fréquence d'interrogation. Si un appareil n'est pas détecté ou si le service d'appareil optionnel n'est pas disponible, ces commandes ne peuvent pas être appliquées via cette page.

## Persistance et réinitialisation

Les paramètres sont stockés en tant qu'état utilisateur et un fragment d'entrée Hyprland généré est régénéré pour la session. Utilisez l'action de réinitialisation de la page lorsque celle-ci est présente ; ne modifiez pas directement le fragment généré. Un paramètre ne peut s'appliquer qu'au compositeur actuel lorsque la session ne peut pas recharger l'état pertinent de l'appareil.

Voir [Centre de contrôle](/docs/components/argvus-control-center/)] et [Où configurer les éléments](/docs/user-guide/where-to-configure/)].
