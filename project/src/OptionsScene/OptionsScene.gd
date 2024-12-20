extends Control

@onready var mul_range_edit: LineEdit = %MultiplyRangeEdit
@onready var div_range_edit: LineEdit = %DivideRangeEdit
@onready var ui_scale_opt: OptionButton = %UIScaleOption


func _ready() -> void:
	var ui_scale = AppSettings.get_setting("ui_scale")
	ui_scale_opt.select(int(ui_scale))
	ui_scale_opt.item_selected.connect(_on_ui_scale_selected)
	
	var mul_range = AppSettings.get_setting("multiply_max_value")
	mul_range_edit.text = str(mul_range)
	mul_range_edit.text_submitted.connect(_on_range_changed.bind("multiply_max_value", mul_range_edit))
	mul_range_edit.focus_exited.connect(_on_range_edit_focus_exit.bind("multiply_max_value", mul_range_edit))
	
	var div_range = AppSettings.get_setting("divide_max_value")
	div_range_edit.text = str(div_range)
	div_range_edit.text_submitted.connect(_on_range_changed.bind("divide_max_value", div_range_edit))
	div_range_edit.focus_exited.connect(_on_range_edit_focus_exit.bind("divide_max_value", div_range_edit))


func _on_range_changed(new_range_txt: String, setting_name: String, range_edit: LineEdit) -> void:
	var new_range = new_range_txt.to_int()
	new_range = clamp(new_range, 2, 20)
	AppSettings.set_setting(setting_name, new_range)
	range_edit.text = str(new_range)


func _on_range_edit_focus_exit(setting_name: String, range_edit: LineEdit) -> void:
	_on_range_changed(range_edit.text, setting_name, range_edit)


func _on_ui_scale_selected(idx: int) -> void:
	var scale_map = {
		0: 0.5,
		1: 1.0,
		2: 2.0,
		3: 3.0,
	}
	var value = scale_map[idx]
	get_tree().root.content_scale_factor = value
	
	AppSettings.set_setting("ui_scale", value)
