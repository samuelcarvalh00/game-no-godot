extends Area2D


func _draw():
	draw_circle(Vector2.ZERO, 20, Color(1, 0.85, 0.2, 0.35))
	draw_rect(Rect2(-14, -5, 26, 10), Color(0.22, 0.22, 0.28))
	draw_rect(Rect2(8, -4, 12, 8), Color(0.32, 0.32, 0.4))
	draw_rect(Rect2(-14, -5, 26, 3), Color(0.5, 0.5, 0.6))
	draw_rect(Rect2(-6, 5, 6, 6), Color(0.25, 0.25, 0.3))


func _on_area_entered(area):
	if area.is_in_group("jogador1") or area.is_in_group("jogador2"):
		if area.has_method("pegar_arma"):
			area.pegar_arma()
		queue_free()
