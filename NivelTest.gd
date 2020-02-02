extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func crearDisparo(laser):
	add_child(laser)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemigoVolador.connect("dispare", self, "crearDisparo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
