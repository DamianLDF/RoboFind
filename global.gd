extends Node

var nivel: int = 1

var vida: int = 3
var max_vida: int = 3 

var tiempo_inicio : int

var pacifico : bool
var perfecto : bool
var asesino : bool

func _ready():
	pass # Replace with function body.


func restar_vida():
	vida -= 1


func cambiar_vida(nueva : int):
	vida = nueva
	max_vida = nueva


func iniciar_tiempo() -> void:
	tiempo_inicio = OS.get_ticks_msec()
	pacifico = true
	perfecto = true
	asesino = true


func tiempo() -> int:
	return OS.get_ticks_msec() - tiempo_inicio