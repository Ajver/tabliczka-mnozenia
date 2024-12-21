extends HBoxContainer

@onready var progress_bar = $ProgressBar
@onready var label = $Label


func setup(text: String, value: float) -> void:
	progress_bar.value = value
	label.text = text
