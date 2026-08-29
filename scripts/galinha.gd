extends Area2D

@export var player_id: int = 1
@export var nome_jogador: String = "Jogador 1"
@export var tipo_inicial: int = 0

var speed = 220
var tm_tela
var posicao_inicial: Vector2

var atordoado_tempo = 0.0
var tem_arma = false

var personagens = ["Galinha", "Sapo", "Cavalo", "Cachorro", "Gato"]
var tipo_personagem = 0

var olhando = Vector2(0, -1)

const Projetil = preload("res://scenes/projetil.tscn")

@onready var label_nome = $NomeLabel
@onready var som = $AudioStreamPlayer2D


func _ready():
	tm_tela = get_viewport_rect().size
	posicao_inicial = position
	add_to_group("jogador%d" % player_id)
	tipo_personagem = tipo_inicial
	atualizar_label()
	queue_redraw()


func atualizar_label():
	if label_nome:
		label_nome.text = "%s\n(%s)" % [nome_jogador, personagens[tipo_personagem]]


func acao_up():
	return "p%d_up" % player_id


func acao_down():
	return "p%d_down" % player_id


func acao_left():
	return "p%d_left" % player_id


func acao_right():
	return "p%d_right" % player_id


func acao_skin():
	return "p%d_skin" % player_id


func acao_atirar():
	return "p%d_atirar" % player_id


func _process(delta):
	if atordoado_tempo > 0:
		atordoado_tempo -= delta
		queue_redraw()
		return

	var mov = Vector2.ZERO
	if Input.is_action_pressed(acao_up()):
		mov.y -= 1
	if Input.is_action_pressed(acao_down()):
		mov.y += 1
	if Input.is_action_pressed(acao_left()):
		mov.x -= 1
	if Input.is_action_pressed(acao_right()):
		mov.x += 1

	if mov != Vector2.ZERO:
		olhando = mov.normalized()

	position += mov * speed * delta
	position.x = clamp(position.x, 40, tm_tela.x - 40)
	position.y = clamp(position.y, 50, tm_tela.y - 50)

	if Input.is_action_just_pressed(acao_skin()):
		trocar_personagem()

	if Input.is_action_just_pressed(acao_atirar()) and tem_arma:
		atirar()

	queue_redraw()


func trocar_personagem():
	tipo_personagem = (tipo_personagem + 1) % personagens.size()
	atualizar_label()


func atordoar(duracao):
	atordoado_tempo = max(atordoado_tempo, duracao)


func pegar_arma():
	tem_arma = true


func atirar():
	tem_arma = false
	var p = Projetil.instantiate()
	get_parent().add_child(p)
	p.global_position = global_position
	p.atirador_id = player_id
	p.direcao = 1 if player_id == 1 else -1


func _on_body_entered(body):
	if body.is_in_group("carro"):
		Global.perder_vida(player_id)
		position = posicao_inicial
		if som:
			som.play()
		if body.has_method("destruicao_do_carro"):
			body.destruicao_do_carro()


func _draw():
	match tipo_personagem:
		0:
			desenhar_galinha()
		1:
			desenhar_sapo()
		2:
			desenhar_cavalo()
		3:
			desenhar_cachorro()
		4:
			desenhar_gato()
	if atordoado_tempo > 0:
		draw_circle(Vector2(0, -42), 7, Color(1, 1, 0))


func triangulo(a, b, c, cor):
	draw_colored_polygon(PackedVector2Array([a, b, c]), cor)


func desenhar_galinha():
	draw_circle(Vector2(0, 6), 22, Color(1, 1, 1))
	draw_circle(Vector2(0, -16), 13, Color(1, 1, 1))
	draw_circle(Vector2(-10, -22), 4, Color(1, 0.3, 0.3))
	draw_circle(Vector2(10, -22), 4, Color(1, 0.3, 0.3))
	draw_circle(Vector2(-5, -17), 3, Color(0, 0, 0))
	draw_circle(Vector2(5, -17), 3, Color(0, 0, 0))
	triangulo(Vector2(-6, -8), Vector2(6, -8), Vector2(0, 0), Color(1, 0.6, 0))


func desenhar_sapo():
	draw_circle(Vector2(0, 10), 24, Color(0.3, 0.8, 0.35))
	draw_circle(Vector2(-13, -14), 10, Color(0.35, 0.85, 0.4))
	draw_circle(Vector2(13, -14), 10, Color(0.35, 0.85, 0.4))
	draw_circle(Vector2(-13, -14), 4, Color(1, 1, 1))
	draw_circle(Vector2(13, -14), 4, Color(1, 1, 1))
	draw_circle(Vector2(-13, -14), 2, Color(0, 0, 0))
	draw_circle(Vector2(13, -14), 2, Color(0, 0, 0))
	triangulo(Vector2(-7, 2), Vector2(7, 2), Vector2(0, 10), Color(0.9, 0.4, 0.45))


func desenhar_cavalo():
	draw_circle(Vector2(0, 12), 20, Color(0.55, 0.36, 0.2))
	draw_rect(Rect2(-8, -24, 16, 26), Color(0.55, 0.36, 0.2))
	draw_circle(Vector2(0, -24), 10, Color(0.6, 0.4, 0.22))
	draw_rect(Rect2(-15, -32, 6, 14), Color(0.4, 0.25, 0.12))
	draw_rect(Rect2(9, -32, 6, 14), Color(0.4, 0.25, 0.12))
	draw_rect(Rect2(-12, -30, 24, 6), Color(0.3, 0.18, 0.08))
	draw_circle(Vector2(-4, -25), 3, Color(0, 0, 0))
	draw_circle(Vector2(4, -25), 3, Color(0, 0, 0))


func desenhar_cachorro():
	draw_circle(Vector2(0, 8), 21, Color(0.82, 0.62, 0.38))
	draw_circle(Vector2(0, -14), 13, Color(0.82, 0.62, 0.38))
	draw_circle(Vector2(-15, -8), 7, Color(0.6, 0.42, 0.24))
	draw_circle(Vector2(15, -8), 7, Color(0.6, 0.42, 0.24))
	draw_circle(Vector2(0, -8), 8, Color(0.95, 0.88, 0.78))
	draw_circle(Vector2(0, -10), 3, Color(0, 0, 0))
	draw_circle(Vector2(-5, -16), 3, Color(0, 0, 0))
	draw_circle(Vector2(5, -16), 3, Color(0, 0, 0))


func desenhar_gato():
	draw_circle(Vector2(0, 8), 19, Color(0.6, 0.6, 0.66))
	draw_circle(Vector2(0, -14), 12, Color(0.6, 0.6, 0.66))
	triangulo(Vector2(-13, -22), Vector2(-3, -20), Vector2(-11, -34), Color(0.6, 0.6, 0.66))
	triangulo(Vector2(13, -22), Vector2(3, -20), Vector2(11, -34), Color(0.6, 0.6, 0.66))
	draw_circle(Vector2(-5, -14), 2.5, Color(0, 0, 0))
	draw_circle(Vector2(5, -14), 2.5, Color(0, 0, 0))
	draw_circle(Vector2(0, -7), 2.5, Color(1, 0.4, 0.5))
	draw_rect(Rect2(18, 6, 22, 5), Color(0.6, 0.6, 0.66))
