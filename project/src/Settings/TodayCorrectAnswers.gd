extends AbstractSettings


func _ready() -> void:
	var today_date = _get_today_date()
	
	if get_setting("today_date") != today_date:
		# New day - let's reset!
		set_setting("today_date", today_date)
		set_setting("correct_multiplies", 0)
		set_setting("correct_divides", 0)


func _get_today_date() -> String:
	var datetime = Time.get_datetime_dict_from_system()
	var today_str = "-".join([datetime["year"], datetime["month"], datetime["day"]])
	return today_str


func __default_settings__() -> Dictionary:
	# counts of how many times the pair was solved correctly
	var default_settings = {
		"today_date": "",
		"correct_multiplies": 0,
		"correct_divides": 0,
	}
	
	return default_settings


func __settings_save_file_path__() -> String:
	var path := "user://today_correct_answers.json"
	return path
