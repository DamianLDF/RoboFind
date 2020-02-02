extends Node2D

onready var fade_in_timer = Timer.new()

func crearDisparo(laser):
	add_child(laser)


func _ready():
	$HUD.actualizar()
	$ParallaxBackground.modulate_color(Color(0,0,0))
	var numero = $Node2D.get_child_count()
	for i in range(numero):
		$Node2D.get_child(i).connect("dispare", self, "crearDisparo")
	fade_in_timer.connect("timeout", self, "fade_in")
	fade_in_timer.wait_time = 0.1
	add_child(fade_in_timer)
	fade_in_timer.start()
	

func fade_in():
	$Player.dar_torso()
	$Player.ajustar_zoom()
	self.modulate = self.modulate + Color(.1, .1, .1)
	$ParallaxBackground.modulate_color(self.modulate)
	if self.modulate.r >= 1:
		fade_in_timer.stop()

func _on_Player_zoom_changed(zoom : Vector2):
	$ParallaxBackground.scale = zoom
	$ParallaxBackground.offset.y = zoom.x * -150


func _on_WinArea_body_entered(body):
	if body.name == "Player":
		global.nivel = 3
		get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")


func _on_Player_cambia_vida():
	$HUD.actualizar()
