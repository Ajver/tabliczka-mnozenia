extends MarginContainer

signal pressed


func _ready() -> void:
	$Button.pressed.connect(_back_to_main_menu)


func _back_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://src/MainMenu/MainMenu.tscn")
