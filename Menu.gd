extends Control

func _ready():
	pass


func _on_Play_button_down():
	global.nivel = 1
	get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")



func _on_Exit_button_down():
	get_tree().quit()
