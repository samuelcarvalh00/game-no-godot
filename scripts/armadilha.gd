extends Area2D


func _draw():
	var pontos = PackedVector2Array([
		Vector2(0, -20), Vector2(18, 15), Vector2(-18, 15)
	])
	draw_colored_polygon(pontos, Color(0.9, 0.1, 0.1))


func _on_area_entered(area):
	if area.is_in_group("jogador1") or area.is_in_group("jogador2"):
		if area.has_method("atordoar"):
			area.atordoar(1.0)
		# empurra o jogador um pouco pra trás, como penalidade
		area.position.y = clamp(area.position.y + 60, 50, area.tm_tela.y - 50)
		queue_free()
