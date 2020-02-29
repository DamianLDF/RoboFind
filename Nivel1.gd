extends Node2D

func _ready():
	global.vida = 3
	global.max_vida = 3
	global.iniciar_tiempo()
	$HUD.actualizar()

func _on_WinArea_body_entered(body):
	if body.name == "Player":
		if $Enemigos.get_child_count() > 0:
			global.asesino = false
		global.nivel = 2
		get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")


func _on_Player_cambia_vida():
	$HUD.actualizar()


func _on_Player_zoom_changed(zoom: Vector2):
	$ParallaxBackground.scale = zoom
	$ParallaxBackground.offset.y = zoom.x * -150
