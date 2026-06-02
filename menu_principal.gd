extends Control
@onready var fondo_animado = $AnimatedSprite2D2

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	# Esto cambia la pantalla actual por la del Nivel 1
	get_tree().change_scene_to_file("res://nivel_1.tscn")

func _on_opciones_pressed() -> void:
	# Escondemos el menú principal y mostramos las armas
	$CajaInicial.hide() 
	$CajaArmas.show()   

func _on_volver_pressed() -> void:
	# Escondemos las armas y volvemos a mostrar el menú principal
	$CajaArmas.hide()   
	$CajaInicial.show()

# Cada que seleccione un arma guarda el dato exacto y te manda a jugar el juego 

func _on_katana_pressed() -> void:
	fondo_animado.play("fondo_katana")
	Global.arma_seleccionada = "katana"


func _on_nunchakus_pressed() -> void:
	fondo_animado.play("fondo_nunchakus")
	Global.arma_seleccionada = "nunchaku"


func _on_bastón_pressed() -> void:
	fondo_animado.play("fondo_bo")
	Global.arma_seleccionada = "bo"


func _on_sais_pressed() -> void:
	fondo_animado.play("fondo_sais")
	Global.arma_seleccionada = "sais"
