extends Control

func _ready():
	global.tiempo_iniciado = false


func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_Play_button_down()
	if event.is_action_pressed("ui_cancel"):
		_on_Exit_button_down()

func _on_Play_button_down():
	global.nivel = 1
	get_tree().call_deferred("change_scene", "res://Intro.tscn")


func _on_Exit_button_down():
	get_tree().quit()
