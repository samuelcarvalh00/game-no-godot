extends CharacterBody2D

var speed = 0.0
var direcao = 1  # 1 = vai pra direita (padrão), -1 = vai pra esquerda (mapa 2)

func _ready():
	add_to_group("carro")
	var sorteiacarro = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var carrocar = sorteiacarro[randi() % sorteiacarro.size()]
	$AnimatedSprite2D.play(carrocar)

	if direcao == -1:
		$AnimatedSprite2D.flip_h = true

	if randf() > 0.5:
		carro_rapido()
	else:
		carro_lento()

func carro_rapido():
	speed = randf_range(700, 750)

func carro_lento():
	speed = randf_range(300, 350)

func _physics_process(_delta):
	velocity = Vector2(direcao, 0) * speed
	move_and_slide()

	if get_slide_collision_count() > 0:
		destruicao_do_carro()

	if position.x < -80 or position.x > 1360:
		destruicao_do_carro()

func destruicao_do_carro():
	queue_free()
