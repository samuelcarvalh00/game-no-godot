extends Node2D

const cenacarro = preload("res://carros.tscn")
const cenaarma = preload("res://scenes/arma.tscn")
const cenaarmadilha = preload("res://scenes/armadilha.tscn")
const cenatrampolim = preload("res://scenes/trampolim.tscn")

@export var nome_mapa: String = "DIA"
@export var cor_fundo: Color = Color(1, 1, 1, 1)
@export var tema_decor: int = 0
@export var carros_dois_lados: bool = false
@export var tem_trampolim: bool = false
@export var espera_rapido: float = 0.30
@export var espera_lento: float = 0.60

const faixarapida = [488, 272, 104]
const faixalenta = [600, 544, 438, 324, 384, 216, 160]
const todas_as_faixas = [104, 160, 216, 272, 324, 384, 438, 488, 544, 600]

@onready var galinha1 = $galinha
@onready var galinha2 = $galinha2
@onready var label_pontos1 = $HUD/Pontos1
@onready var label_pontos2 = $HUD/Pontos2
@onready var label_vidas1 = $HUD/Vidas1
@onready var label_vidas2 = $HUD/Vidas2
@onready var label_objetivo = $HUD/Objetivo
@onready var fundo = $Fundo


func _ready():
	Global.resetar_jogo()
	fundo.modulate = cor_fundo
	if label_objetivo:
		label_objetivo.text = "OBJETIVO: cruze a rua ate a LINHA DE CHEGADA! (%s)" % nome_mapa
	atualizar_hud()
	if tem_trampolim:
		_criar_trampolim()
	$Timercarrorapido.wait_time = espera_rapido
	$Timercarrolento.wait_time = espera_lento


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


func _spawn_carro(rapido):
	var c = cenacarro.instantiate()
	if carros_dois_lados:
		if randf() > 0.5:
			c.direcao = 1
			c.position.x = -10
		else:
			c.direcao = -1
			c.position.x = 1290
	else:
		c.position.x = -10
	var faixas = faixarapida if rapido else faixalenta
	c.position.y = faixas[randi() % faixas.size()]
	add_child(c)
	if rapido:
		c.carro_rapido()
	else:
		c.carro_lento()


func _on_timercarrorapido_timeout():
	_spawn_carro(true)


func _on_timercarrolento_timeout():
	_spawn_carro(false)


func _on_timerarmadilha_timeout():
	var a = cenaarmadilha.instantiate()
	add_child(a)
	a.position.x = randf_range(150, 1100)
	a.position.y = todas_as_faixas[randi() % todas_as_faixas.size()]


func _on_timerarma_timeout():
	var a = cenaarma.instantiate()
	add_child(a)
	a.position.x = randf_range(150, 1100)
	a.position.y = todas_as_faixas[randi() % todas_as_faixas.size()]
