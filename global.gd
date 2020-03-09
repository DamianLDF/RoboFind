extends Node

var nivel: int = 1

var vida: int = 3
var max_vida: int = 3 

var tiempo_inicio : int
var tiempo_fin : int
var tiempo_iniciado : bool = false

var pacifista : bool
var perfecto : bool
var rapido : bool
var asesino : bool

func _ready():
	pass # Replace with function body.


func restar_vida():
	vida -= 1


func cambiar_vida(nueva : int):
	vida = nueva
	max_vida = nueva


func iniciar_tiempo() -> void:
	if not tiempo_iniciado:
		tiempo_iniciado = true
		tiempo_inicio = OS.get_ticks_msec()
		pacifista = true
		perfecto = true
		rapido = false
		asesino = true


func tiempo() -> int:
	return OS.get_ticks_msec() - tiempo_inicio


func texto_tiempo(tiempo_par : int = 0) -> String:
	var tiempo : int = tiempo_par
	if tiempo_par == 0:
		tiempo = global.tiempo()
	var milis : int = tiempo % 1000
#warning-ignore:integer_division
	var segundos : int = tiempo / 1000
#warning-ignore:integer_division
	var minutos : int = segundos / 60
	var texto : String ="%02d:" % minutos + \
						"%02d." % (segundos % 60) + \
						"%03d" % milis
	return texto

func terminar_tiempo() -> void:
	tiempo_fin = tiempo()
	if tiempo_fin < 240000:
		rapido = true
	