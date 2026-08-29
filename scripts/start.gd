extends Node

func _on_botao_jogar_pressed():
	get_tree().change_scene_to_file("res://scenes/mapa_select.tscn")

func _on_botao_comojogar_pressed():
	get_tree().change_scene_to_file("res://scenes/como_jogar.tscn")
