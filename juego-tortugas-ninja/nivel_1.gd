extends Node2D

# 1. Esto tiene que ir aquí arriba. Revisa que "pizza.tscn" sea exactamente el nombre de tu archivo.
var molde_pizza = preload("res://pizza.tscn")
var molde_bomba = preload("res://bomba.tscn")
var puntos = 0
var vidas = 5
	
func _ready() -> void:
	pass

func _on_timeout() -> void:
	# 1. Elegimos una posición al azar en la pantalla
	var posicion_x_azar = randf_range(50, 750)
	
	# 2. Tiramos el dado virtual del 1 al 10
	var dado = randi_range(1, 10)
	var nuevo_objeto
	
	# 3. Decidimos qué fabricar
	if dado <= 7:
		nuevo_objeto = molde_pizza.instantiate()
	else:
		nuevo_objeto = molde_bomba.instantiate()
		
	# 4. Lo colocamos y lo añadimos a la pantalla
	nuevo_objeto.position = Vector2(posicion_x_azar, 650)
	add_child(nuevo_objeto)
	
func sumar_punto() -> void:
	puntos += 10
	$HUD/Textopuntos.text = "Puntos: " + str(puntos)

func restar_vida() -> void:
	vidas -= 1
	$HUD/Textovidas.text = "Vidas: " + str(vidas)
	
	if vidas <= 0:
		print("¡Game Over! Te quedaste sin vidas.")
