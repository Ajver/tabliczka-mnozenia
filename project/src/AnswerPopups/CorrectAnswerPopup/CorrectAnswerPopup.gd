extends Control

signal animation_end

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hide()
	animation_player.animation_finished.connect(_on_animation_finished)


func play() -> void:
	show()
	animation_player.play("fade_in")


func _on_animation_finished(_anim_name: String) -> void:
	animation_end.emit()
	hide()
