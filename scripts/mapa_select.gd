extends Node

func _on_mapa_dia_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_mapa_noite_pressed():
	get_tree().change_scene_to_file("res://scenes/main2.tscn")

func _on_mapa_neve_pressed():
	get_tree().change_scene_to_file("res://scenes/mapa_neve.tscn")

func _on_mapa_espaco_pressed():
	get_tree().change_scene_to_file("res://scenes/mapa_espaco.tscn")

func _on_botao_comojogar_pressed():
	get_tree().change_scene_to_file("res://scenes/como_jogar.tscn")

func _on_botao_voltar_pressed():
	get_tree().change_scene_to_file("res://scenes/start.tscn")
