extends Node2D

@export var tema: int = 0

var pontos = []
var raios = []


func _ready():
	randomize()
	if tema == 2 or tema == 3:
		for i in 80:
			pontos.append(Vector2(randf() * 1280, randf() * 720))
			raios.append(randf() * 1.5 + 1)


func _draw():
	if tema == 3:
		for i in pontos.size():
			draw_circle(pontos[i], raios[i], Color(1, 1, 1, 0.7))
	elif tema == 2:
		for i in pontos.size():
			draw_circle(pontos[i], 2, Color(1, 1, 1, 0.85))
