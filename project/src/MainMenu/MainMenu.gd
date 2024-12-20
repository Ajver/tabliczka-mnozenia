extends Control

@export var multiplying_scene: PackedScene
@export var dividing_scene: PackedScene
@export var stats_scene: PackedScene
@export var options_scene: PackedScene


func _ready() -> void:
	%MultiplyBtn.pressed.connect(_change_scene_to.bind(multiplying_scene))
	%DivideBtn.pressed.connect(_change_scene_to.bind(dividing_scene))
	%StatsBtn.pressed.connect(_change_scene_to.bind(stats_scene))
	%OptionsBtn.pressed.connect(_change_scene_to.bind(options_scene))


func _change_scene_to(new_scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(new_scene)
