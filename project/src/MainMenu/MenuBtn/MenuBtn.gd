extends MarginContainer

signal pressed


func _ready() -> void:
	$Button.pressed.connect(pressed.emit)
