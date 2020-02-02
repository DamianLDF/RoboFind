extends Node2D

onready var fade_in_timer = Timer.new()

func _ready():

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