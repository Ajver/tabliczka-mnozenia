extends AbstractSettings


func __default_settings__() -> Dictionary:
	# counts of how many times the pair was solved correctly
	var default_settings = {
		"2:1": 0,
		"4:2": 0,
		# ... Automatically generated
	}
	
	for a in range(1, 21):
		for b in range(1, 21):
			default_settings[str(a*b, ":", b)] = 0
	
	return default_settings


func __settings_save_file_path__() -> String:
	var path := "user://divide_memory.json"
	return path
