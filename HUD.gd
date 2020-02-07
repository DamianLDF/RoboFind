extends CanvasLayer

func _ready():
	pass

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