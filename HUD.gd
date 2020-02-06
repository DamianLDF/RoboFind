extends CanvasLayer

func _ready():
	pass


func actualizar():
	$Vida.max_value = global.max_vida
	$Vida.value = global.vida
	

func mostrar_jefe():
	$Jefe.visible = true
	
func actualizar_jefe(vida:int, vida_max:int):
	$Jefe/HSplitContainer/ProgressBar.max_value = vida_max
	$Jefe/HSplitContainer/ProgressBar.value = vida