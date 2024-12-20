extends AbstractSettings


func _ready() -> void:
	var ui_scale = get_setting("ui_scale")
	get_tree().root.content_scale_factor = ui_scale


func __default_settings__() -> Dictionary:
	# counts of how many times the pair was solved correctly
	var default_settings = {
		"multiply_max_value": 10,
		"divide_max_value": 10,
		"ui_scale": 1.0,
	}
	
	return default_settings


func __settings_save_file_path__() -> String:
	var path := "user://app_settings.json"
	return path
