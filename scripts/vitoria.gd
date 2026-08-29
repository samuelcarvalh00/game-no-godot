extends Node

@onready var label_vencedor = $LabelVencedor

func _ready():
	label_vencedor.text = "%s venceu!" % Global.nome_jogador[Global.vencedor]

func _on_botao_jogar_de_novo_pressed():
	get_tree().change_scene_to_file("res://scenes/start.tscn")
