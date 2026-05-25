extends Node2D

# 1. Esto tiene que ir aquí arriba. Revisa que "pizza.tscn" sea exactamente el nombre de tu archivo.
var molde_pizza = preload("res://pizza.tscn")

func _ready() -> void:
	pass

func _on_timeout() -> void:
	print("¡El reloj funcionó y fabricó una pizza!")
	var posicion_x_azar = randf_range(50, 750)
	var nueva_pizza = molde_pizza.instantiate()
	nueva_pizza.position = Vector2(posicion_x_azar,650)
	add_child(nueva_pizza)
