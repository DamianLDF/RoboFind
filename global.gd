extends Node

var nivel: int = 1

var vida: int = 3
var max_vida: int = 3 

func _ready():
	pass # Replace with function body.


func restar_vida():
	vida -= 1


func cambiar_vida(nueva : int):
	vida = nueva
	max_vida = nueva
