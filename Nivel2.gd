extends Node2D

onready var fade_in_timer = Timer.new()

func _ready():
	$ParallaxBackground.modulate_color(Color(0,0,0))
	
#	var fade_in_timer : SceneTreeTimer = get_tree().create_timer(1)
	fade_in_timer.connect("timeout", self, "fade_in")
	fade_in_timer.wait_time = 0.05
	
#	yield(get_tree().create_timer(1),"timeout")
	add_child(fade_in_timer)
	fade_in_timer.start()
	$Player.dar_torso()
	

func fade_in():
	print(str(self.modulate))
	self.modulate = self.modulate + Color(.1, .1, .1)
	$ParallaxBackground.modulate_color(self.modulate)
	if self.modulate.r >= 1:
		fade_in_timer.stop()