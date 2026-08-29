extends Area2D

@export var impulso: float = 110.0


func _draw():
	draw_circle(Vector2.ZERO, 20, Color(0.2, 0.9, 0.3))
	draw_circle(Vector2.ZERO, 12, Color(0.1, 0.6, 0.2))


func _on_area_entered(area):
	if area.is_in_group("jogador1") or area.is_in_group("jogador2"):
		area.position.y = clamp(area.position.y - impulso, 50, area.tm_tela.y - 50)
