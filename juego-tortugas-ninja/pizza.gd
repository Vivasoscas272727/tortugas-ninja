extends RigidBody2D



func _ready() -> void:
	#hace que salente los obejetos a los lados al azar
	var fuerza_x = randf_range(-150,150)
	var fuerza_y = -1100
	apply_central_impulse(Vector2(fuerza_x,fuerza_y))


func _process(delta: float) -> void:
	pass
