extends Node

# Mapa 2: igual ao mapa 1, mas com carros vindo dos dois lados
# (ponto extra: "diferentes níveis de dificuldade como carros em
# duas direções").

const cenacarro = preload("res://carros.tscn")
const cenaarma = preload("res://scenes/arma.tscn")
const cenaarmadilha = preload("res://scenes/armadilha.tscn")
const cenatrampolim = preload("res://scenes/trampolim.tscn")

const faixarapida = [488, 272, 104]
const faixalenta = [600, 544, 438, 324, 384, 216, 160]
const todas_as_faixas = [104, 160, 216, 272, 324, 384, 438, 488, 544, 600]

@onready var galinha1 = $galinha
@onready var galinha2 = $galinha2
@onready var label_pontos1 = $HUD/Pontos1
@onready var label_pontos2 = $HUD/Pontos2
@onready var label_vidas1 = $HUD/Vidas1
@onready var label_vidas2 = $HUD/Vidas2


func _ready():
	Global.resetar_jogo()
	atualizar_hud()
	_criar_trampolim()


func _criar_trampolim():
	var t = cenatrampolim.instantiate()
	add_child(t)
	t.position = Vector2(760, 384)


func _process(_delta):
	atualizar_hud()
	if Global.vencedor != 0:
		get_tree().change_scene_to_file("res://scenes/vitoria.tscn")


func atualizar_hud():
	label_pontos1.text = "P1: %d" % Global.pontos[1]
	label_pontos2.text = "P2: %d" % Global.pontos[2]
	label_vidas1.text = "Vidas: %d" % Global.vidas[1]
	label_vidas2.text = "Vidas: %d" % Global.vidas[2]


func _on_linha_de_chegada_area_entered(area):
	var jogador = 0
	if area.is_in_group("jogador1"):
		jogador = 1
	elif area.is_in_group("jogador2"):
		jogador = 2

	if jogador != 0:
		area.position = area.posicao_inicial
		Global.marcar_ponto(jogador)
		$AudioStreamPlayer2D.play()


func _on_timercarrorapido_timeout():
	var spawncarro = cenacarro.instantiate()
	if randf() > 0.5:
		spawncarro.direcao = 1
		spawncarro.position.x = -10
	else:
		spawncarro.direcao = -1
		spawncarro.position.x = 1290
	spawncarro.position.y = faixarapida[randi() % faixarapida.size()]
	add_child(spawncarro)
	spawncarro.carro_rapido()


func _on_timercarrolento_timeout() -> void:
	var spawncarro = cenacarro.instantiate()
	if randf() > 0.5:
		spawncarro.direcao = 1
		spawncarro.position.x = -10
	else:
		spawncarro.direcao = -1
		spawncarro.position.x = 1290
	spawncarro.position.y = faixalenta[randi() % faixalenta.size()]
	add_child(spawncarro)
	spawncarro.carro_lento()


func _on_timerarmadilha_timeout() -> void:
	var a = cenaarmadilha.instantiate()
	add_child(a)
	a.position.x = randf_range(150, 1100)
	a.position.y = todas_as_faixas[randi() % todas_as_faixas.size()]


func _on_timerarma_timeout() -> void:
	var a = cenaarma.instantiate()
	add_child(a)
	a.position.x = randf_range(150, 1100)
	a.position.y = todas_as_faixas[randi() % todas_as_faixas.size()]
