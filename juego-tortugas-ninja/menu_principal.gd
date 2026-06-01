extends Control

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

#cada que seleccione un arma te mande a jugar el juego 

func _on_katana_pressed() -> void:
	get_tree().change_scene_to_file("res://nivel_1.tscn")
func _on_nunchakus_pressed() -> void:
	get_tree().change_scene_to_file("res://nivel_1.tscn")
func _on_bastón_pressed() -> void:
	get_tree().change_scene_to_file("res://nivel_1.tscn")
func _on_sais_pressed() -> void:
	get_tree().change_scene_to_file("res://nivel_1.tscn")
