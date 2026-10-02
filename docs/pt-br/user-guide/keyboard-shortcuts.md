---
title: Atalhos de teclado
description: Consulte os atalhos da configuração Hyprland.
slug: pt/0.4.0/docs/user-guide/desktop/keyboard-shortcuts
---

Abra **Control Center → Localidade e região → Atalhos de teclado**, ou execute `argvus-control-center keybindings`.

## O que a página faz

A página busca e agrupa o manifesto de atalhos ativo. Você pode selecionar um atalho, editar sua combinação, capturar uma nova combinação, ativar ou desativar um atalho configurável e restaurar todos os atalhos pela ação de restauração da página. Um atalho precisa conter uma tecla que não seja apenas modificador; o editor normaliza nomes como Super/Win, Ctrl, Alt, Shift, setas, teclas de função e teclas multimídia. `SUPER + Y` abre **Control Center → Appearance → Wallpapers**.

As alterações são salvas em `config.json`, em `/keyboard_shortcuts`; o fragmento Hyprland gerado fica em `~/.config/argvus/data/generated/hypr/`. Um atalho desativado é representado por `null`. As chaves são estáveis, em inglês e independentes do locale: um ID como `window.close` vira `close_window`, enquanto `window.drag_mouse` vira `drag_window__floating_window_only`. A seção antiga `/hyprland/keybindings` e `keybindings.toml` servem apenas como fontes de migração. O ARGVUS agenda reload da sessão somente quando o plano de projeção informa uma mudança real.

O editor altera bindings que já existem no manifesto do ARGVUS. Para adicionar um binding manual completamente novo ou uma ação do compositor, use [`bindings.lua`](./hyprland-overrides/) em vez de editar o fragmento gerado.

## Referência atual

O manifesto base e os cheatsheets instalados ficam em `/usr/share/argvus/hyprland/`. O override do usuário não substitui o manifesto: ele altera as entradas selecionadas no Control Center. Por isso, uma lista copiada manualmente pode ficar desatualizada.

Algumas ações incluídas são mover foco e áreas de trabalho, alternar janelas flutuantes, capturas e gravação, abrir lançador/terminal, alterar aparência, bloquear a sessão, controlar mídia e recarregar o Hyprland. A lista completa pertence ao manifesto instalado e pode ser pesquisada no Control Center.

`SUPER + Shift + R` é o reload explícito do runtime: recarrega o Hyprland e reinicia os serviços da taskbar, do Control Panel e do Widget Telemetry. Reloads acionados por configuração continuam condicionais e não fazem reload gráfico quando o estado canônico não mudou.

Veja [Janelas e layout](./windows-and-layout/) para comportamento de janelas flutuantes e áreas de trabalho e [Control Center](../control-center/) para o fluxo de configurações.
