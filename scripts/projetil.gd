extends Area2D

var direcao = 1
var atirador_id = 1
var velocidade = 500.0


func _draw():
	draw_rect(Rect2(-9, -3, 18, 6), Color(1, 0.9, 0.2))
	draw_circle(Vector2(9, 0), 3.5, Color(1, 0.5, 0.1))
	draw_circle(Vector2(-9, 0), 3, Color(0.9, 0.3, 0.1))


func _physics_process(delta):
	position.x += direcao * velocidade * delta
	if position.x < -60 or position.x > 1340:
		queue_free()


func _on_area_entered(area):
	if area.is_in_group("jogador1") and atirador_id != 1:
		area.atordoar(1.5)
		queue_free()
	elif area.is_in_group("jogador2") and atirador_id != 2:
		area.atordoar(1.5)
		queue_free()
