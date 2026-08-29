extends Node

# ---------------------------------------------------------
# Estado global do jogo: pontos, vidas, nomes e mapa escolhido.
# Isso fica acessível de qualquer script como "Global.algo"
# porque está registrado em Project > Project Settings > Autoload.
# ---------------------------------------------------------

var pontos = {1: 0, 2: 0}
var vidas = {1: 3, 2: 3}
var vidas_iniciais = 3
var pontos_para_vencer = 12

var nome_jogador = {1: "Jogador 1", 2: "Jogador 2"}

var mapa_selecionado = "res://main.tscn"
var vencedor = 0 # 0 = ninguém venceu ainda


func resetar_jogo():
	pontos = {1: 0, 2: 0}
	vidas = {1: vidas_iniciais, 2: vidas_iniciais}
	vencedor = 0


func marcar_ponto(jogador: int):
	pontos[jogador] += 1
	if pontos[jogador] >= pontos_para_vencer:
		vencedor = jogador


func perder_vida(jogador: int):
	vidas[jogador] -= 1
	if vidas[jogador] <= 0:
		var outro = 2 if jogador == 1 else 1
		vencedor = outro
