extends MarginContainer

@export var default_color: Color
@export var accent_color: Color

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label


func _ready() -> void:
	var btn : TextureButton = $Button
	btn.pressed.connect(_back_to_main_menu)
	btn.mouse_entered.connect(_on_btn_hover_over)
	btn.mouse_exited.connect(_on_btn_hover_end)
	btn.button_down.connect(_on_btn_down)


func _on_btn_hover_over() -> void:
	label.modulate = accent_color
	texture_rect.modulate = accent_color


func _on_btn_hover_end() -> void:
	label.modulate = default_color
	texture_rect.modulate = default_color


func _on_btn_down() -> void:
	AudioPlayer.play("click")


func _back_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://src/MainMenu/MainMenu.tscn")
