extends AbstractSettings


func __default_settings__() -> Dictionary:
	# counts of how many times the pair was solved correctly
	var default_settings = {
		"1x1": 0,
		"1x2": 0,
		# ... Automatically generated
	}
	
	for a in range(1, 21):
		for b in range(1, 21):
			default_settings[str(a, "x", b)] = 0
	
	return default_settings


func __settings_save_file_path__() -> String:
	var path := "user://multiply_memory.json"
	return path
