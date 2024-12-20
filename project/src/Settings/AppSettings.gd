extends AbstractSettings


func __default_settings__() -> Dictionary:
	# counts of how many times the pair was solved correctly
	var default_settings = {
		"multiply_max_value": 10,
		"divide_max_value": 10,
	}
	
	return default_settings


func __settings_save_file_path__() -> String:
	var path := "user://app_settings.json"
	return path
