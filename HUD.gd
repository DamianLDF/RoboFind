extends CanvasLayer

func _ready():
	pass


func actualizar():
	$Vida.max_value = global.max_vida
	$Vida.value = global.vida