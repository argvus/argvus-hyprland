---
title: Mouse e touchpad
description: Configure o comportamento do ponteiro e do touchpad no ARGVUS.
slug: pt/0.4.0/docs/user-guide/hardware/input
---

Abra **Control Center → Localidade e região → Mouse e touchpad**, ou execute `argvus-control-center input`.

## Mouse

Quando um mouse é detectado, a página oferece:

* sensibilidade de `-1.0` a `1.0`;
* perfil de aceleração adaptativo ou plano;
* fator de rolagem de `0.1` a `10.0`;
* rolagem natural;
* disposição de botões para canhotos.

Sensibilidade, fator de rolagem e toggles são aplicados pelo Hyprland enquanto a página está aberta e, em seguida, o estado completo de entrada é salvo. Quando não existe arquivo de entrada do ARGVUS, a página lê o valor atual do compositor.

## Touchpad

Quando um touchpad é detectado, a página oferece rolagem natural, toque para clicar, toque e arraste, clique direito com dois dedos e desativar enquanto digita. Esses controles só são úteis quando a sessão ativa informa a presença de um touchpad.

## Controles dependentes do hardware

Controles avançados de mouse fornecidos pelo `ratbag` aparecem apenas para dispositivos compatíveis. O ARGVUS não afirma que todo mouse suporta alterações de DPI, perfis ou polling. Se um dispositivo não for detectado ou o serviço opcional não estiver disponível, esses controles não poderão ser aplicados por esta página.

## Persistência e restauração

As configurações são armazenadas como estado de usuário e um fragmento de entrada Hyprland gerado é regenerado para a sessão. Use a ação de restauração da página quando presente; não edite o fragmento gerado diretamente. Uma alteração pode ser aplicada apenas ao compositor atual quando a sessão não puder recarregar o estado do dispositivo correspondente.

Veja [Control Center](/pt/docs/argvus-control-center/) e [Onde configurar as coisas](/pt/docs/user-guide/where-to-configure/).
