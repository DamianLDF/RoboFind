extends Node2D

onready var fade_in_timer = Timer.new()
onready var fade_out_timer = Timer.new()

func _ready():
#	modulate_color(Color(0,0,0))
	set_process(false)
	$ParallaxBackground.modulate_color(Color(0,0,0))
	$Logros/Tiempo.text = "Tiempo: " + global.texto_tiempo(global.tiempo_fin - global.tiempo_inicio)
	if global.asesino:
		$Logros/Asesino.set_visible(true)
	if global.rapido:
		$Logros/Rapido.set_visible(true)
	if global.pacifista:
		$Logros/Pacifista.set_visible(true)
	if global.perfecto:
		$Logros/Perfecto.set_visible(true)
	yield(get_tree().create_timer(3), "timeout")
	set_process(true)
	fade_in_timer.connect("timeout", self, "fade_in")
	fade_in_timer.wait_time = 0.1
	add_child(fade_in_timer)
	fade_in_timer.start()
	
	fade_out_timer.connect("timeout", self, "fade_out")
	fade_out_timer.wait_time = 0.1
	add_child(fade_out_timer)
	
	yield(get_tree().create_timer(4), "timeout")
	$Logros/Tiempo.set_visible(false)
	$Logros/Asesino.set_visible(false)
	$Logros/Rapido.set_visible(false)
	$Logros/Pacifista.set_visible(false)
	$Logros/Perfecto.set_visible(false)
	
	yield(get_tree().create_timer(86), "timeout")
	fade_out_timer.start()


func fade_in():
	self.modulate = self.modulate + Color(.02, .02, .02)
	$ParallaxBackground.modulate_color(self.modulate)
	if self.modulate.r >= 1:
		fade_in_timer.stop()


func fade_out():
	self.modulate = self.modulate - Color(.05, .05, .05, 0)
	$ParallaxBackground.modulate_color(self.modulate)
	if self.modulate.r <= 0:
		fade_out_timer.stop()
		get_tree().call_deferred("change_scene", "res://Menu.tscn")


func _process(delta):
	$Robot.position.x += 200 * delta
	if $Robot.position.x > 13600:
		$Robot.scale.x *= 1 - .5 * delta
		$Robot.scale.y = $Robot.scale.x
		if $Robot.scale.x < 0.01:
			$Robot.set_visible(false)
	if $CanvasLayer/Texto.rect_position.y > -1250:
		$CanvasLayer/Texto.rect_position.y -= 30 * delta