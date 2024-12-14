class_name AbstractSettings
extends Node

signal setting_changed(setting_name, new_value)

var _save_file_path : String

var _settings : Dictionary

# Setting name is key, array of listeners (array: [Node, signal_name]) is value
var _settings_changes_listeners : Dictionary


func _init() -> void:
	_save_file_path = __settings_save_file_path__()
	_settings = __default_settings__()
	_load_settings_from_file()


func get_setting(setting_name:String):
	assert(_settings.has(setting_name))
	
	var value = _settings[setting_name]
	return value


func set_setting(setting_name:String, value, force_reset:bool=false) -> void:
	assert(_settings.has(setting_name))
	
	var old_value = _settings[setting_name]
	
	if not force_reset and _are_the_same_and_the_same_type(old_value, value):
		return
	
	_settings[setting_name] = value
	
	_on_setting_changed(setting_name, value)
	_save_settings_to_file()


func has_setting(setting_name:String) -> bool:
	var has = _settings.has(setting_name)
	return has


func connect_to_setting_change(setting_name:String, node:Node, method_name:String) -> void:
	if not is_instance_valid(node):
		push_error("Invalid node, connectiong aborded")
		return
	
	if not node.has_method(method_name):
		push_error("Node '%s'%s doesn't have the method '%s', connection aborded" % [node.name, node, method_name])
		return
	
	if not _settings_changes_listeners.has(setting_name):
		_settings_changes_listeners[setting_name] = []
	
	var listener = [node, method_name]
	_settings_changes_listeners[setting_name].append(listener)


func _are_the_same_and_the_same_type(a, b) -> bool:
	var type_a = typeof(a)
	var type_b = typeof(b)
	
	if not type_a == type_b:
		return false
	
	var are_the_same = a == b
	return are_the_same


func _on_setting_changed(setting_name:String, value) -> void:
	if _settings_changes_listeners.has(setting_name):
		var invalid_listeners = []
		
		for listener in _settings_changes_listeners[setting_name]:
			var node = listener[0]
			if is_instance_valid(node):
				var method = listener[1]
				node.call(method, value)
			else:
				invalid_listeners.append(listener)
	
		for listener in invalid_listeners:
			print("removing listener for setting_name: ", setting_name)
			_settings_changes_listeners[setting_name].erase(listener)
	
	emit_signal("setting_changed", setting_name, value)


func _save_settings_to_file() -> void:
	var file := FileAccess.open(_save_file_path, FileAccess.WRITE)
	
	if not file.is_open():
		print("Cannot open file to write. Error: " + str(file.get_error()))
		return
	
	var str_settings = JSON.stringify(_settings)
	
	file.store_line(str_settings)
	
	file.close()


func _load_settings_from_file() -> void:
	if not FileAccess.file_exists(_save_file_path):
		return
	
	var file := FileAccess.open(_save_file_path, FileAccess.READ)
	
	if not file.is_open():
		print("Cannot open save file. Error: " + str(file.get_error()))
		return
	
	var str_settings := file.get_as_text()
	var test_json_conv = JSON.new()
	
	var error = test_json_conv.parse(str_settings)
	if error != OK:
		print("Error while reading save file. File contnent is not Dictionary!")
		return
	
	var json_settings = test_json_conv.get_data()
	
	if json_settings is Dictionary:
		_override_settings(json_settings)
	else:
		print("Error while reading save file. File contnent is not Dictionary!")
	
	file.close()


func _override_settings(dict:Dictionary) -> void:
	for key in dict.keys():
		_settings[key] = dict[key]


# To override - return DEFAULT _settings value here
func __default_settings__() -> Dictionary:
	var default_settings := {}
	return default_settings


# To override - return settings save file path
func __settings_save_file_path__() -> String:
	var path := "user://settings_%s.json" % name
	return path
