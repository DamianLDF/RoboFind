extends CanvasLayer

func _ready():
	pass


#warning-ignore:unused_argument
func _process(delta):
	var tiempo : int = global.tiempo()
	var milis : int = tiempo % 1000
#warning-ignore:integer_division
	var segundos : int = tiempo / 1000
#warning-ignore:integer_division
	var minutos : int = segundos / 60
	$Timer.text =	"%02d:" % minutos + \
					"%02d." % (segundos % 60) + \
					"%03d" % milis


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().call_deferred("change_scene", "res://Menu.tscn")
	elif event.is_action_pressed("ui_accept"):
		get_tree().paused = not get_tree().paused


func actualizar():
	$Vida.max_value = global.max_vida
	$Vida.value = global.vida
	

func mostrar_jefe():
	$Jefe.visible = true
	
	
func actualizar_jefe(vida:int, vida_max:int):
	$Jefe/HSplitContainer/ProgressBar.max_value = vida_max
	$Jefe/HSplitContainer/ProgressBar.value = vida