---
title: Janelas e layout
description: Entenda gaps, bordas, modos e espaço dos painéis no ARGVUS.
---

O ARGVUS usa o Hyprland para posicionar janelas tileadas e flutuantes. Os controles de layout ficam em três páginas do Control Center: **Control Center → Aparência → Barra de tarefas** (posição, espaçamentos e ícones), **Control Center → Desktop e entrada → Hyprland → Janelas → Espaços** e **Control Center → Desktop e entrada → Hyprland → Bordas**.

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

## Modos Sticky e Spaced

Os modos dos temas incluídos fornecem duas geometrias iniciais:

| Modo | Comportamento das janelas | Tratamento das superfícies |
| --- | --- | --- |
| Sticky | Gap interno `2`, gap externo `0` por padrão | Quadrado, compacto e próximo à borda |
| Spaced | Gap interno `10`, gap externo `18` por padrão | Arredondado, com sombra e mais espaçoso; margem padrão de taskbar/shell `18` |

Esses são valores padrão, não limites. As páginas Espaços das janelas e Espaçamentos da barra de tarefas podem guardar gaps das janelas e margens da taskbar de forma independente. Alterar tema ou modo pode projetar valores efetivos de layout diferentes.

## Controles de layout

Cada controle é independente e fica na página indicada:

* **Barra de tarefas → Posição** — borda superior ou inferior.
* **Barra de tarefas → Espaçamentos** — margens superior, esquerda, direita e inferior, cada uma de `0` a `100`. Sticky usa margem inferior padrão `2`; Spaced usa `18`.
* **Barra de tarefas → Ícones** — comportamento automático ou sempre expandido do grupo utilitário da taskbar.
* **Hyprland → Janelas → Espaços** — gap interno e gaps externos superior/esquerdo/direito/inferior, cada um de `0` a `100`.
* **Hyprland → Bordas** — bordas gerais: ativa cantos arredondados; quando ativos, o arredondamento varia de `2` a `10`. A espessura da borda também fica aqui, de `0` a `10`.
* **Hyprland → Bordas → Sombra** — a sombra das janelas, desligada por padrão. Define alcance, potência de renderização, cantos nítidos, deslocamentos e escala; a cor segue o destaque do tema com alfa `99`, a menos que uma cor seja digitada.

Esses valores são escritos no estado de aparência do ARGVUS, e o `argvus-config` os projeta nos ficheiros Hyprland gerados que a sessão aplica em seguida. Uma margem da taskbar muda a posição da superfície do shell; um gap externo muda a área das janelas lado a lado. Eles podem produzir uma distância visual parecida, mas alterar um não altera o outro.

## Janelas e ambientes de trabalho

Janelas tileadas são organizadas pelo Hyprland no ambiente de trabalho ativa. O ARGVUS também suporta janelas utilitárias flutuantes; `SUPER + SHIFT + Space` alterna a janela em foco entre os layouts tileado e flutuante. Movimento entre áreas e foco de janelas são controlados pelo manifesto de atalhos ativo; veja [Atalhos de teclado](/pt/docs/argvus-hyprland/keyboard-shortcuts/).

A configuração do pacote abre o Control Center, o Snake e o Disk Usage Analyzer como janelas flutuantes e centralizadas. O Disk Usage Analyzer usa a mesma geometria inicial de `1399 × 920` do popup de memória da taskbar, aplicada pela regra de classe quando a janela abre. ARGVUS Focus e ARGVUS Clock são popups GTK layer-shell ancorados junto à taskbar; não são janelas tileadas e não usam regras de janela do Hyprland. O cartão de alarme do Clock é uma superfície de camada separada (`argvus-clock-alarm`).

O Control Panel usa uma superfície layer-shell em ecrã cheia enquanto o modal está aberto. As regras do pacote deixam flutuantes, centralizam e fixam as janelas do agente Polkit, do portal GTK e do KDialog para que os diálogos abertos pelo painel apareçam acima do modal e recebam entrada.

O `hyprpicker`, aberto por `SUPER + P`, não usa animação do Hyprland. Essa exceção afeta apenas o seletor de cores; as demais animações continuam seguindo as definições globais.

### Posicionamento de workspace para navegadores e IDEs

Nenhuma regra de janela é definida por padrão em uma instalação nova. Você pode adicionar suas próprias regras de posicionamento por aplicação em `hyprland.window_rules` no `argvus-config`, por exemplo:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

Cada regra tem um `workspace` de 1 a 10 e uma lista `classes`. Os itens de `classes` são expressões regulares comparadas à classe da janela (diferencia maiúsculas), por exemplo `[Cc]ode.*` ou `jetbrains-.*`. Só são aceitos letras, dígitos e `._*+?-[]()|^$`. O `argvus-config` grava as regras em `generated/hypr/window-rules.lua`, que a configuração do Hyprland carrega. Para trocar as regras sem alterar os padrões, adicione chamadas `hl.window_rule` ao `rules.lua` no diretório de dados do ARGVUS; elas são carregadas depois das regras geradas.

## O que alterar primeiro

* Se as janelas estiverem apertadas, aumente o gap da janela ou use o modo Spaced.
* Se as janelas estiverem muito afastadas da borda, reduza o espaço externo/taskbar ou use Sticky.
* Se a taskbar parecer desalinhada depois de mudar sua posição, revise a posição e as quatro margens da taskbar em conjunto.
* Se as janelas cobrirem um painel visual, verifique as definições de painel e taskbar antes de alterar os gaps.

As alterações são aplicadas pela integração de aparência e sessão do ARGVUS. Use a ação de restauração da página quando disponível; não edite ficheiros Hyprland gerados diretamente.

## Relacionados

* [Aparência](/pt/docs/user-guide/appearance/)
* [Temas](/pt/docs/user-guide/appearance/)
* [Taskbar](/pt/docs/argvus-taskbar/taskbar/)
* [Control Panel](/pt/docs/argvus-control-panel/)

## Wobble das janelas

Abra **Desktop e entrada → Hyprland → Animações → Janelas** e use os controles
**Wobble**. Busque por `wobble` ou abra a página diretamente:

```sh
argvus control-center hyprland animations windows
```

O Wobble começa desativado. Os padrões do ARGVUS são rigidez `100`, amortecimento
`10`, massa `1`, intensidade `1` e resolução da malha `8`. Rigidez e massa aceitam
`0.0001–1000`, amortecimento `0–1000`, intensidade `0–2` e malha um inteiro `2–32`.
Uma malha maior aumenta o custo de renderização. Use as setas para ajustar valores
ou Enter para digitá-los. **Restaurar padrões do Wobble** altera o rascunho;
**Aplicar** salva todas as edições de animações pendentes e recarrega o Hyprland
uma vez, sem reiniciar a sessão. Voltar dentro de Animações mantém o rascunho
compartilhado.

A chave global de Animações desativa o Wobble sem perder suas definições
individuais. Os valores canônicos ficam em `effects.wobble_*` no estado do ARGVUS;
`hypr/state.lua` é gerado e não deve ser editado manualmente.

O recurso exige Hyprland **0.57.0 ou superior**, garantido pela dependência do
pacote `argvus-hyprland`. A versão 0.56 não é compatível com esta configuração.
O máximo de intensidade segue o [código da versão 0.57.0](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),
que limita o valor a `2`, embora a documentação mais recente possa indicar `3`.

## Modo global de janelas

Abra **Control Center → Desktop e entrada → Hyprland → Janelas → Modo** e escolha **Janelas em mosaico (padrão)** ou **Janelas flutuantes**. O mesmo seletor está disponível pelo ícone de modo de janelas no grupo de utilitários da taskbar.

A preferência vale para todos os monitores e workspaces e permanece após encerrar a sessão. O modo flutuante converte janelas existentes de aplicações e novas janelas. O modo mosaico restaura apenas as janelas convertidas pela política; diálogos e outras janelas que já eram flutuantes permanecem assim. Uma janela explicitamente fixada durante o modo flutuante também permanece flutuante para preservar sua fixação. O layout em mosaico é recalculado; a árvore exata de divisões anterior não é restaurada.

`SUPER + SHIFT + Space` mantém o comportamento individual no modo mosaico. No modo flutuante, não coloca uma janela em mosaico. Painéis, taskbar e notificações são superfícies layer-shell e não são afetados. Ecrã cheia continua seguindo o comportamento do Hyprland; a maximização ARGVUS preserva as margens em Spaced.

A preferência canônica é `/hyprland/window_mode`, em `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. A projeção gerada é `data/generated/hypr/window-mode.lua`; não edite esse ficheiro. O registro de restauração por janela fica em `$XDG_RUNTIME_DIR/argvus`, separado por instância do compositor, e sobrevive ao reload da configuração. Ele não é reutilizado em uma nova sessão.

Se a aplicação estiver pendente ou falhar, a interface distingue esse estado da preferência salva. Selecione novamente a opção para tentar outra vez. Sem compositor, a preferência fica salva para o próximo login.

## Botões de janela e barra de aplicações

O modo flutuante adiciona uma barra de título ARGVUS com **Minimizar**, **Maximizar / Restaurar** e **Fechar** às janelas normais de aplicações. O clique duplo na barra alterna a maximização. A decoração adicional fica oculta em mosaico e ecrã cheia. Aplicações que desenham seus próprios controles podem exibir as duas barras; os controles ARGVUS uniformes são intencionais.

Uma segunda Waybar aparece em cada monitor, na borda oposta à taskbar principal. Ela lista apenas as janelas do workspace atual daquele monitor, incluindo as minimizadas desse workspace. Abas ocultas de grupos não geram entradas extras. As minimizadas mantêm a associação ao monitor e workspace originais. Clique em uma janela sem foco para ativá-la, na janela ativa para minimizá-la ou em uma minimizada para restaurá-la; o menu de contexto oferece restaurar, minimizar, maximizar/restaurar e fechar. Ícones de aplicações desconhecidos usam um símbolo de janela. A ativação e a restauração pela lista preservam a posição do ponteiro. A barra secundária usa o CSS efetivo da principal (cores, fontes, borda e arredondamento), com altura e margens espelhadas na borda oposta.

`SUPER + Alt + seta para cima` coloca a barra principal no topo e a barra de janelas no rodapé. `SUPER + Alt + seta para baixo` faz o inverso. Repetir a direção mantém as posições. Em mosaico existe apenas a barra principal. Voltar ao mosaico restaura todas as minimizadas antes de remover a barra de janelas e então preserva a política original de janelas tiled/flutuantes.

A minimização usa o workspace reservado `special:argvus-minimized`. Não use esse workspace manualmente. O processo `argvus windows service` registra identidade, workspace/monitor de origem, geometria, ecrã cheia/maximização e fixação em um registro de runtime separado por instância do compositor, em `$XDG_RUNTIME_DIR/argvus`. Os registros sobrevivem ao reinício do serviço ou reload da configuração, mas não atravessam sessões do compositor. Fechar uma janela remove seu registro. Se um monitor desaparecer, a restauração usa uma saída disponível. Uma barra de recuperação ausente ou com falha impede novas minimizações; falhas de restauração preservam o registro e a barra de recuperação.

A sessão gerencia `argvus-windows.service` e `argvus-window-bar.service`. O segundo mantém sua Waybar inativa em mosaico. O plugin hyprbars é distribuído por `argvus-hyprland`, compilado para a ABI do Hyprland 0.57.0 em x86_64; não é compilado no diretório pessoal do utilizador. Recompile o plugin ao atualizar a ABI do compositor.

Comandos: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` e `minimize|restore|activate|maximize|close ADDRESS`. Os endereços das janelas vêm da listagem. `position top --persist` salva/projeta a preferência sem reiniciar a barra principal. Detalhes de erros vão para o journal; falhas de ações visíveis também exibem uma notificação traduzida.

No modo **Spaced + Floating**, as janelas respeitam os espaços externos e as áreas reservadas pelas duas barras. O cálculo inclui a borda e o título, que fica dentro da mesma borda da janela. Maximizar pelos controles ARGVUS ocupa essa área com margens; restaurar recupera a geometria anterior, inclusive após reiniciar o serviço. Ecrã cheia continua usando o monitor inteiro. Janelas flutuantes podem se sobrepor; os espaços internos do mosaico não separam essas janelas.

`SUPER + Alt + Espaço` alterna o modo global entre mosaico e flutuante, usando a mesma preferência da taskbar e do Control Center. O comando equivalente é `argvus config window-mode toggle`. Acionamentos simultâneos são serializados; a alternância considera a preferência salva, mesmo quando sua aplicação está pendente. O atalho pode ser alterado ou desativado em Atalhos de teclado; `SUPER + Shift + Espaço` mantém a ação individual.
