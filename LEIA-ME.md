# Freeway Bolado — o que foi implementado

Abra a pasta inteira no Godot 4.7 (Project > Import, aponte pro `project.godot`).
Na primeira vez ele vai reimportar os assets — normal, só esperar.

## Como jogar
- **Jogador 1**: Seta ↑ / Seta ↓ para mover, **K** troca de skin, **L** atira (se tiver arma).
- **Jogador 2**: **W** / **S** para mover, **T** troca de skin, **Y** atira (se tiver arma).

Objetivo: atravessar a rua repetidamente. Cada travessia = 1 ponto.
Quem chegar a **12 pontos primeiro** vence. Cada jogador tem **3 vidas**;
ao ser atropelado por um carro, perde 1 vida, volta pro início e — se
zerar as vidas — o outro jogador vence na hora.

## Itens do Q1 cobertos

**1. Dois jogadores, sprites e controles diferentes**
`galinha.tscn` virou um script genérico (`galinha.gd`) que recebe um
`player_id` (1 ou 2). Cada instância escuta um conjunto de teclas
diferente (`p1_*` / `p2_*`), configurado em Project Settings > Input Map
(já vem pronto no `project.godot`).

**2. Objetivo pra terminar a fase**
Sistema de pontos (`Global.gd`) + vidas. 12 pontos ou zerar a vida do
adversário decide o jogo. Ao vencer, o jogo troca pra `scenes/vitoria.tscn`.

**3. Nova funcionalidade do player**
Troca de skin (cor da galinha, tecla própria por jogador) e nome do
jogador exibido acima do personagem (`NomeLabel` dentro de `galinha.tscn`).

**4. Tela inicial**
`scenes/start.tscn`: fundo + botão "JOGAR", que leva para
`scenes/mapa_select.tscn` (escolha entre Mapa 1 e Mapa 2).

**Pontos extra:**
- **Mapa 2** (`scenes/main2.tscn`): carros vêm dos dois lados (mais difícil).
- **Armadilhas**: a cada 90s (`TimerArmadilha`) aparece uma armadilha
  aleatória que atordoa e empurra o jogador pra trás.
- **Armas**: a cada 12s aparece uma arma coletável; quem pega pode
  atirar (`atirar()`), atordoando o adversário por 1,5s.
- **Trampolim**: no Mapa 2 tem um trampolim que empurra o jogador pra
  frente ao tocar.

## Sobre as "skins" e sprites
Não incluí sprites de personagens novos porque não vieram no projeto —
implementei skins como variações de cor (mais rápido e já conta como
"trocar a skin"). Se você quiser skins de verdade (bonecos diferentes),
dois lugares bons e gratuitos:
- https://kenney.nl/assets (pacotes "Animal Pack", "Toon Characters")
- https://itch.io/game-assets/free/tag-2d (filtra por "sprite", licença livre)

Baixe o sprite sheet, importe no Godot, crie um novo `SpriteFrames` e
troque no `AnimatedSprite2D` da cena `galinha.tscn` (ou crie uma
segunda versão da cena pra cada skin, se preferir algo mais simples
que o sistema de cor que já está pronto).

## Coisas pra você conferir no editor (posso ter zerado algum ajuste fino)
- Posição/tamanho do `NomeLabel` acima da galinha — como a galinha
  tem escala 0.3, pode precisar ajustar visualmente no editor.
- Posições dos botões nas telas de início/seleção de mapa/vitória —
  testei os números pela resolução do viewport (1280x720), mas vale
  abrir e conferir visualmente.
- Volume/velocidade dos carros no Mapa 2 — ajustei um pouco mais
  rápido que o Mapa 1, mas sinta livre pra calibrar a dificuldade.

## Não implementado (ficou de fora por escopo/tempo)
- Trocar de mapa "ao vivo" durante uma partida (só dá pra escolher
  antes de começar, na tela de seleção) — atende ao pedido "poder
  trocar o mapa" mas não é um botão dentro do jogo.
- Sprites de skins reais (só cor, como explicado acima).
