---
title: Janelas e layout
description: Entenda gaps, bordas, modos e espaço dos painéis no ARGVUS.
slug: pt/0.4.0/docs/user-guide/desktop/windows-and-layout
---

O ARGVUS usa o Hyprland para posicionar janelas tileadas e flutuantes. Os controles de layout ficam em **Control Center → Aparência → Espaços, bordas e posição** e também aparecem no card de aparência correspondente do Control Panel.

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

Esses são valores padrão, não limites. A página Espaços, bordas e posição pode salvar gaps das bordas e margens da taskbar de forma independente. Alterar tema ou modo pode projetar valores efetivos de layout diferentes.

## Controles de Espaços, bordas e posição

A página oferece estes controles independentes:

* **Posição da taskbar** — borda superior ou inferior.
* **Espaços da taskbar** — margens superior, esquerda, direita e inferior, cada uma de `0` a `100`.
* **Espaços das janelas** — gap interno e gaps externos superior/esquerdo/direito/inferior, cada um de `0` a `100`.
* **Bordas gerais** — ativa cantos arredondados; quando ativos, o arredondamento varia de `2` a `10`.
* **Espessura da borda** — de `0` a `10`.
* **Grupo utilitário** — comportamento automático ou sempre expandido do grupo utilitário da taskbar.

Esses valores são escritos no estado de aparência do ARGVUS, e o `argvus-config` os projeta nos arquivos Hyprland gerados que a sessão aplica em seguida. Uma margem da taskbar muda a posição da superfície do shell; um gap externo muda a área das janelas lado a lado. Eles podem produzir uma distância visual parecida, mas alterar um não altera o outro.

## Janelas e áreas de trabalho

Janelas tileadas são organizadas pelo Hyprland na área de trabalho ativa. O ARGVUS também suporta janelas utilitárias flutuantes; `SUPER + SHIFT + Space` alterna a janela em foco entre os layouts tileado e flutuante. Movimento entre áreas e foco de janelas são controlados pelo manifesto de atalhos ativo; veja [Atalhos de teclado](/pt/docs/argvus-hyprland/keyboard-shortcuts/).

## O que alterar primeiro

* Se as janelas estiverem apertadas, aumente o gap da janela ou use o modo Float.
* Se as janelas estiverem muito afastadas da borda, reduza o espaço externo/taskbar ou use Sticky.
* Se a taskbar parecer desalinhada depois de mudar sua posição, revise a posição e as quatro margens da taskbar em conjunto.
* Se as janelas cobrirem um painel visual, verifique as configurações de painel e taskbar antes de alterar os gaps.

As alterações são aplicadas pela integração de aparência e sessão do ARGVUS. Use a ação de restauração da página quando disponível; não edite arquivos Hyprland gerados diretamente.

## Relacionados

* [Aparência](../appearance/)
* [Temas](/pt/docs/argvus-themes/)
* [Taskbar](./taskbar/)
* [Control Panel](./control-panel/)
