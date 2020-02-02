extends Node2D

func _ready():
	$HUD.actualizar()

func _on_WinArea_body_entered(body):
	if body.name == "Player":
		global.nivel = 2
		get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")



func _on_Player_cambia_vida():
	$HUD.actualizar()
