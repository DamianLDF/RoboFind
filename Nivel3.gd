extends Node2D

onready var fade_in_timer = Timer.new()

func crearDisparo(disparo):
	add_child(disparo)

func _ready():
	$HUD.actualizar()
	var numero = $Enemigos.get_child_count()
	for i in range(numero):
		$Enemigos.get_child(i).connect("dispare", self, "crearDisparo")
	fade_in_timer.connect("timeout", self, "fade_in")
	fade_in_timer.wait_time = 0.1
	add_child(fade_in_timer)
	fade_in_timer.start()


func fade_in():
	$Player.dar_cuerpo()
	$Player.ajustar_zoom()
	self.modulate = self.modulate + Color(.1, .1, .1)
	$ParallaxBackground.modulate_color(self.modulate)
	if self.modulate.r >= 1:
		fade_in_timer.stop()

func _on_Player_cambia_vida():
	$HUD.actualizar()


func _on_BossArea_body_entered(body):
	$Ambiente.stop()
	$PeleaJefe.play()
	$HUD.mostrar_jefe()


func _on_EnemigoFinal_cambia_vida(vida:int, vida_max:int)->void:
	$HUD.actualizar_jefe(vida, vida_max)


func _on_EnemigoFinal_muere():
	global.nivel = 4
	get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")

