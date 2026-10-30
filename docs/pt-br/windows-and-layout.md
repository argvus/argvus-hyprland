---
title: Janelas e layout
description: Entenda gaps, bordas, modos e espaço dos painéis no ARGVUS.
---

O ARGVUS usa o Hyprland para posicionar janelas tileadas e flutuantes. Os controles de layout ficam em três páginas do Control Center: **Control Center → Aparência → Barra de tarefas** (posição, espaçamentos e ícones), **Control Center → Desktop e entrada → Hyprland → Espaços das janelas** e **Control Center → Desktop e entrada → Hyprland → Bordas**.

## Os conceitos

```text
┌────────────────────────────────────┐
│          espaço externo / painel   │
│   ┌────────────┐  gap     ┌──────┐  │
│   │   janela   │ interno  │janela│  │
│   └────────────┘          └──────┘  │
│       borda ao redor da janela      │
└────────────────────────────────────┘
```

* **Gaps das janelas** são o espaço entre janelas tileadas e a borda externa do layout tileado.
* **Espaço da taskbar ou shell** é a margem ao redor de superfícies do desktop, como taskbar e painel. Não é o mesmo valor que gap de janela.
* **Bordas** são a borda visível desenhada ao redor da janela. **Espessura da borda** controla a largura exposta pela página de aparência.
* **Arredondamento** faz parte do modo visual selecionado. Ele altera o formato dos cantos, não move a janela.
* **Reserva do painel e margem visível** são conceitos separados: um painel pode usar espaço visual enquanto o Hyprland organiza janelas segundo o estado de espaçamento ativo.

## Modos Sticky e Float

Os modos dos temas incluídos fornecem duas geometrias iniciais:

| Modo | Comportamento das janelas | Tratamento das superfícies |
| --- | --- | --- |
| Sticky | Gap interno `2`, gap externo `0` por padrão | Quadrado, compacto e próximo à borda |
| Float | Gap interno `10`, gap externo `18` por padrão | Arredondado, com sombra e mais espaçoso; margem padrão de taskbar/shell `18` |

Esses são valores padrão, não limites. As páginas Espaços das janelas e Espaçamentos da barra de tarefas podem salvar gaps das janelas e margens da taskbar de forma independente. Alterar tema ou modo pode projetar valores efetivos de layout diferentes.

## Controles de layout

Cada controle é independente e fica na página indicada:

* **Barra de tarefas → Posição** — borda superior ou inferior.
* **Barra de tarefas → Espaçamentos** — margens superior, esquerda, direita e inferior, cada uma de `0` a `100`. Sticky usa margem inferior padrão `2`; Float usa `18`.
* **Barra de tarefas → Ícones** — comportamento automático ou sempre expandido do grupo utilitário da taskbar.
* **Hyprland → Espaços das janelas** — gap interno e gaps externos superior/esquerdo/direito/inferior, cada um de `0` a `100`.
* **Hyprland → Bordas** — bordas gerais: ativa cantos arredondados; quando ativos, o arredondamento varia de `2` a `10`. A espessura da borda também fica aqui, de `0` a `10`.
* **Hyprland → Bordas → Sombra** — a sombra das janelas, desligada por padrão. Define alcance, potência de renderização, cantos nítidos, deslocamentos e escala; a cor segue o destaque do tema com alfa `99`, a menos que uma cor seja digitada.

Esses valores são escritos no estado de aparência do ARGVUS, e o `argvus-config` os projeta nos arquivos Hyprland gerados que a sessão aplica em seguida. Uma margem da taskbar muda a posição da superfície do shell; um gap externo muda a área das janelas lado a lado. Eles podem produzir uma distância visual parecida, mas alterar um não altera o outro.

## Janelas e áreas de trabalho

Janelas tileadas são organizadas pelo Hyprland na área de trabalho ativa. O ARGVUS também suporta janelas utilitárias flutuantes; `SUPER + SHIFT + Space` alterna a janela em foco entre os layouts tileado e flutuante. Movimento entre áreas e foco de janelas são controlados pelo manifesto de atalhos ativo; veja [Atalhos de teclado](/pt/docs/argvus-hyprland/keyboard-shortcuts/).

A configuração do pacote abre o Control Center e o Snake como janelas flutuantes e centralizadas. ARGVUS Focus e ARGVUS Clock são popups GTK layer-shell ancorados junto à taskbar; não são janelas tileadas e não usam regras de janela do Hyprland. O cartão de alarme do Clock é uma superfície de camada separada (`argvus-clock-alarm`).

O Control Panel usa uma superfície layer-shell em tela cheia enquanto o modal está aberto. As regras do pacote deixam flutuantes, centralizam e fixam as janelas do agente Polkit, do portal GTK e do KDialog para que os diálogos abertos pelo painel apareçam acima do modal e recebam entrada.

### Posicionamento de workspace para navegadores e IDEs

Nenhuma regra de janela é definida por padrão em uma instalação nova. Você pode adicionar suas próprias regras de posicionamento por aplicativo em `hyprland.window_rules` no `argvus-config`, por exemplo:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

Cada regra tem um `workspace` de 1 a 10 e uma lista `classes`. Os itens de `classes` são expressões regulares comparadas à classe da janela (diferencia maiúsculas), por exemplo `[Cc]ode.*` ou `jetbrains-.*`. Só são aceitos letras, dígitos e `._*+?-[]()|^$`. O `argvus-config` grava as regras em `generated/hypr/window-rules.lua`, que a configuração do Hyprland carrega. Para trocar as regras sem alterar os padrões, adicione chamadas `hl.window_rule` ao `rules.lua` no diretório de dados do ARGVUS; elas são carregadas depois das regras geradas.

## O que alterar primeiro

* Se as janelas estiverem apertadas, aumente o gap da janela ou use o modo Float.
* Se as janelas estiverem muito afastadas da borda, reduza o espaço externo/taskbar ou use Sticky.
* Se a taskbar parecer desalinhada depois de mudar sua posição, revise a posição e as quatro margens da taskbar em conjunto.
* Se as janelas cobrirem um painel visual, verifique as configurações de painel e taskbar antes de alterar os gaps.

As alterações são aplicadas pela integração de aparência e sessão do ARGVUS. Use a ação de restauração da página quando disponível; não edite arquivos Hyprland gerados diretamente.

## Relacionados

* [Aparência](/pt/docs/user-guide/appearance/)
* [Temas](/pt/docs/user-guide/appearance/)
* [Taskbar](/pt/docs/argvus-taskbar/taskbar/)
* [Control Panel](/pt/docs/argvus-control-panel/)
