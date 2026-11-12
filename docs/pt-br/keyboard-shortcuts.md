---
title: Atalhos de teclado
description: Consulte os atalhos da configuração Hyprland.
---

Abra **Control Center → Desktop e entrada → Atalhos de Teclado**, ou execute `argvus control-center keybindings`.

## O que a página faz

**Todos os atalhos** busca e agrupa o manifesto de atalhos ativo. Você pode selecionar um atalho, editar sua combinação, capturar uma nova combinação, ativar ou desativar um atalho configurável e restaurar todos os atalhos pela ação de restauração da página. Um atalho precisa conter uma tecla que não seja apenas modificador; o editor normaliza nomes como Super/Win, Ctrl, Alt, Shift, setas, teclas de função e teclas multimídia. `SUPER + Y` abre **Control Center → Appearance → Wallpapers**.

As alterações de atalhos oficiais são salvas em `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`, representadas por `/keyboard_shortcuts` no modelo lógico; o fragmento Hyprland gerado fica em `~/.config/argvus/data/generated/hypr/`. Um atalho desativado é representado por `null`. As chaves são estáveis, em inglês e independentes do locale: um ID como `window.close` vira `close_window`, enquanto `window.drag_mouse` vira `drag_window__floating_window_only`. A seção antiga `/hyprland/keybindings` e `keybindings.toml` servem apenas como fontes de migração. O ARGVUS agenda reload da sessão somente quando o plano de projeção informa uma mudança real.

**Criar atalhos** cria um atalho global de teclado independentemente do manifesto empacotado. Informe descrição, teclas e um comando ou dispatcher Lua suportado (por exemplo `window.float` com argumentos JSON `{"action":"toggle"}`). **Criar** salva e aplica o atalho, depois o seleciona em **Todos os atalhos → Atalhos personalizados**. Cancelar ou `Esc` descarta o rascunho. Criação e captura não executam o comando.

Os personalizados podem ser editados, ativados/desativados e excluídos com confirmação. Conflitos com atalhos ativos no mesmo contexto pedem confirmação para substituir; bindings protegidos não podem ser substituídos. Restaurar padrões oficiais preserva os registros personalizados. Se a restauração causar colisão com um personalizado ativo, altere ou desative esse personalizado antes de restaurar. As definições ficam em `/hyprland/custom_shortcuts`, em `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. O arquivo gerado `data/generated/hypr/custom-shortcuts.lua` usa o carregador protegido existente; falhas de registro são registradas no log sem interromper o restante da configuração. Falhas de gravação preservam o rascunho; falhas de aplicação informam que o registro foi salvo e permitem tentar novamente.

Execute `argvus control-center shortcuts create` ou `argvus control-center shortcuts list` para abrir as subtelas. Para submaps, bindings do mouse ou flags avançadas, [`bindings.lua`](/pt/docs/argvus-hyprland/hyprland-overrides/) continua disponível. Nunca edite os fragmentos gerados.

## Referência atual

O manifesto base e os cheatsheets instalados ficam em `/usr/share/argvus/hyprland/`. O override do usuário não substitui o manifesto: ele altera as entradas selecionadas no Control Center. Por isso, uma lista copiada manualmente pode ficar desatualizada.

Algumas ações incluídas são mover foco e áreas de trabalho, alternar janelas flutuantes, capturas e gravação, abrir lançador/terminal, alterar aparência, bloquear a sessão, controlar mídia e recarregar o Hyprland. Os atalhos padrão estão listados na [tabela de atalhos padrão](#tabela-de-atalhos-padrão) abaixo; a página do Control Center mostra os atalhos como estão configurados atualmente.

`SUPER + Shift + R` é o reload explícito do runtime: recarrega o Hyprland e reinicia os serviços da taskbar, do Control Panel e do Widget Telemetry. Reloads acionados por configuração continuam condicionais e não fazem reload gráfico quando o estado canônico não mudou.

## Tabela de atalhos padrão

A tabela lista os atalhos do manifesto base (`/usr/share/argvus/hyprland/keybindings.json`) com as teclas padrão. As alterações feitas no Control Center substituem as teclas mostradas aqui para os atalhos afetados, e atalhos desativados não são executados.

### Navegação

| Atalho | Descrição |
| --- | --- |
| `SUPER + Left Arrow` | Focar janela tileada por direção |
| `SUPER + Right Arrow` | Focar janela tileada por direção |
| `SUPER + Up Arrow` | Focar janela tileada por direção |
| `SUPER + Down Arrow` | Focar janela tileada por direção |
| `SUPER + CTRL + Left Arrow` | Ciclar foco entre janelas (tileadas e flutuantes) |
| `SUPER + CTRL + Right Arrow` | Ciclar foco entre janelas (tileadas e flutuantes) |

### Áreas de trabalho

| Atalho | Descrição |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Circular entre áreas de trabalho |
| `CTRL + ALT + Left Arrow` | Circular entre áreas de trabalho |
| `Mouse extra button (mouse:276)` | Circular entre áreas de trabalho |
| `Mouse side button (mouse:275)` | Circular entre áreas de trabalho |
| `SUPER + 1` | Área de trabalho 1 |
| `SUPER + 2` | Área de trabalho 2 |
| `SUPER + 3` | Área de trabalho 3 |
| `SUPER + 4` | Área de trabalho 4 |
| `SUPER + 5` | Área de trabalho 5 |
| `SUPER + 6` | Área de trabalho 6 |
| `SUPER + 7` | Área de trabalho 7 |
| `SUPER + 8` | Área de trabalho 8 |
| `SUPER + 9` | Área de trabalho 9 |
| `SUPER + CTRL + 1` a `SUPER + CTRL + 9` | Abre o projeto dessa posição do `argvus projects` |
| `SUPER + Shift + 1` | Mover janela para a área de trabalho 1 |
| `SUPER + Shift + 2` | Mover janela para a área de trabalho 2 |
| `SUPER + Shift + 3` | Mover janela para a área de trabalho 3 |
| `SUPER + Shift + 4` | Mover janela para a área de trabalho 4 |
| `SUPER + Shift + 5` | Mover janela para a área de trabalho 5 |
| `SUPER + Shift + 6` | Mover janela para a área de trabalho 6 |
| `SUPER + Shift + 7` | Mover janela para a área de trabalho 7 |
| `SUPER + Shift + 8` | Mover janela para a área de trabalho 8 |
| `SUPER + Shift + 9` | Mover janela para a área de trabalho 9 |

### Janelas

| Atalho | Descrição |
| --- | --- |
| `SUPER + S` | Maximizar janela (toggle) |
| `SUPER + Q` | Fechar janela |
| `SUPER + Shift + Space` | Ativa/Desativa Janela flutuante |
| `SUPER + F` | Tela cheia |
| `SUPER + E` | Alternar split vertical/horizontal |
| `SUPER + W` | Agrupar/Desagrupar em abas |
| `SUPER + Tab` | Navegar entre abas |
| `SUPER + Shift + Left Arrow` | Mover janela |
| `SUPER + Shift + Right Arrow` | Mover janela |
| `SUPER + Shift + Up Arrow` | Mover janela |
| `SUPER + Shift + Down Arrow` | Mover janela |
| `SUPER + Left mouse button (mouse:272)` | Arrastar janela (apenas flutuante) |
| `SUPER + Right mouse button (mouse:273)` | Modo redimensionar janela (apenas flutuante) |
| `SUPER + R` | Entrar modo redimensionar janela (apenas flutuante) |

### Aplicativos

| Atalho | Descrição |
| --- | --- |
| `SUPER + Enter` | Terminais |
| `SUPER + [` | Terminal suspenso (scratchpad em workspace especial; pressione de novo para ocultar) |
| `SUPER + Space` | Gerenciador de arquivos |
| `SUPER + CTRL + Space` | Monitor do sistema |
| `SUPER + Shift + D` | Menu de dispositivos removíveis |
| `SUPER + Shift + F` | ARGVUS Focus (Pomodoro e sessões de foco) |
| `SUPER + Shift + C` | ARGVUS Clock (relógio, temporizadores e alarmes) |
| `SUPER + D` | Lançador de programas |
| `SUPER + B` | Navegador padrão |
| `SUPER + C` | Calculadora |
| `SUPER + ALT + S` | Seletor de hosts SSH (`argvus ssh`) |
| `SUPER + ALT + N` | Seletor de snippets (`argvus snippets`) |
| `SUPER + ALT + G` | Seletor de projetos e TUI de git (lazygit ou gitui) no projeto escolhido (`argvus git`) |

### Mídia

| Atalho | Descrição |
| --- | --- |
| `XF86AudioRaiseVolume` | Aumentar volume |
| `Volume Down` | Diminuir volume |
| `Mute` | Silenciar |
| `Brightness Up` | Aumentar brilho |
| `Brightness Down` | Diminuir brilho |
| `Play/Pause` | Reproduzir/Pausar |
| `Next Track` | Próxima faixa |
| `Previous Track` | Faixa anterior |
| `Stop` | Parar faixa |

### Capturas e gravação

| Atalho | Descrição |
| --- | --- |
| `Print` | Capturar área selecionada |
| `SUPER + Print` | Capturar janela em foco |
| `SUPER + Shift + Print` | Capturar tela inteira |
| `SUPER + G` | Iniciar/Pausar/Retomar gravação de tela |
| `SUPER + Shift + G` | Parar e salvar gravação de tela |

### Sessão

| Atalho | Descrição |
| --- | --- |
| `SUPER + L` | Bloquear sistema |
| `SUPER + escape` | Sair do sistema |
| `SUPER + Shift + R` | Recarregar Hyprland |
| `SUPER + Shift + S` | Desligar/Ligar monitor (não é suspender) |
| `SUPER + Shift + L` | Escolhe o tempo de bloqueio por inatividade |
| `SUPER + ALT + W` | Ativa/Desativa manter acordado |

### Sistema

| Atalho | Descrição |
| --- | --- |
| `SUPER + Shift + /` | Cheatsheets do Hyprland |
| `SUPER + CTRL + /` | Cheatsheets do Kitty |
| `SUPER + F1` | Abrir Sobre o ARGVUS |
| `SUPER + ALT + C` | Abrir o Control Center |
| `SUPER + P` | Seletor de cores (Color Picker) |
| `SUPER + .` | Seletor de Emoji |
| `SUPER + H` | Histórico no Clipboard |
| `SUPER + Shift + H` | Apagar histórico do Clipboard |

### Widgets

| Atalho | Descrição |
| --- | --- |
| `SUPER + ,` | Abre/Fecha sidebar de notificações |
| `Middle mouse button (mouse:274)` | Abre/Fecha sidebar de notificações |
| `SUPER + Backspace` | Oculta/Mostra Waybar top |
| `SUPER + Shift + W` | Configura a localização do clima |
| `SUPER + ALT + Up Arrow` | Mover barra de tarefas para o topo |
| `SUPER + ALT + Down Arrow` | Mover barra de tarefas para a parte inferior |

### Aparência

| Atalho | Descrição |
| --- | --- |
| `SUPER + Y` | Abre os wallpapers do Control Center |
| `SUPER + Shift + T` | Abre o seletor de temas |
| `SUPER + Shift + M` | Abre o seletor de modo Sticky/Spaced |
| `SUPER + F5` | Alterna entre os temas ARGVUS Dark e ARGVUS Light |
| `SUPER + F6` | Ativa/Desativa animações |
| `SUPER + Shift + B` | Abre o seletor de brilho e a ação de luz noturna |

### Modo redimensionar (após SUPER + R)

Estes atalhos valem somente enquanto o modo redimensionar está ativo. `Esc` ou `Enter` saem do modo.

| Atalho | Descrição |
| --- | --- |
| `Right Arrow` | Redimensionar |
| `Left Arrow` | Redimensionar |
| `Up Arrow` | Redimensionar |
| `Down Arrow` | Redimensionar |
| `Shift + Right Arrow` | Mover janela |
| `Shift + Left Arrow` | Mover janela |
| `Shift + Up Arrow` | Mover janela |
| `Shift + Down Arrow` | Mover janela |
| `escape` | Sair modo redimensionar |
| `Enter` | Sair modo redimensionar |


Veja [Janelas e layout](/pt/docs/argvus-hyprland/windows-and-layout/) para comportamento de janelas flutuantes e áreas de trabalho e [Control Center](/pt/docs/components/argvus-control-center/) para o fluxo de configurações.

## Luz noturna

**SUPER + Shift + B** preserva a ação `appearance.brightness` no manifesto canônico de atalhos. O menu Rofi de brilho também oferece luz noturna quando o Hyprsunset está disponível. Configure temperatura (1000–20000 K) e horários locais em **Central de Controle > Área de trabalho e entrada > Monitores > Luz noturna**. A ação rápida usa a CLI compartilhada e não recarrega o Hyprland nem altera Lua gerado.


Com argvus-ai instalado, SUPER + A abre o menu de agentes de IA. O atalho respeita overrides app.ai e deixa de ser carregado após remoção do pacote e reload do compositor. Até o reload, a ação protegida fica inativa.


O pacote opcional argvus-ai fornece /usr/share/argvus/ai/hyprland.lua. O Hyprland carrega esse módulo de forma protegida antes dos overrides do usuário; sem o módulo, o bind desaparece no reload. O pacote Hyprland fornece um hook Pacman que atualiza somente o timestamp da configuração do sistema após instalação/atualização/remoção do módulo, acionando o autoreload nativo. Se o autoreload estiver desabilitado ou houver uma configuração raiz própria, recarregue essa configuração explicitamente. O catálogo do Control Center inclui app.ai com a mesma combinação e descrição traduzida; o bind permanece inativo sem o módulo opcional.


## Terminal de pacotes

Estas teclas se aplicam dentro de **Control Center > System Administration > Packages**, não globalmente no Hyprland. `F8` reabre o terminal da transação, `Esc` oculta sem parar o processo, `Shift+PageUp/PageDown` percorre o histórico, `Shift+End` volta à saída atual e `Ctrl+C` interrompe o processo em foco. O cheatsheet instalado inclui as mesmas teclas.

Em Pacotes, `/` foca a barra **Buscar** do topo. `Enter` nela envia consultas de instalação aos repositórios/AUR; as listas de remoção e atualização filtram ao digitar. `↓` vai aos resultados, `↑` no primeiro resultado volta à busca e `Esc` na busca preserva a consulta e volta à lista. Enter num resultado executa a ação do pacote.
