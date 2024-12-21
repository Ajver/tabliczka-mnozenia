extends Control

@export var AnswerProgressBarLeft: PackedScene
@export var AnswerProgressBarRight: PackedScene

@onready var today_correct_multiplies_label: Label = %TodayCorrectMultipliesLabel
@onready var today_correct_divides_label: Label = %TodayCorrectDividesLabel
@onready var total_correct_multiplies_label: Label = %TotalCorrectMultipliesLabel
@onready var total_correct_divides_label: Label = %TotalCorrectDividesLabel
@onready var multiplies_tier_list: Control = %MultipliesTierList
@onready var divides_tier_list: Control = %DividesTierList


func _ready() -> void:
	_fill_today_correct_answers_labels()
	_fill_total_correct_multiplies_label()
	_fill_total_correct_divides_label()
	_fill_multiplies_tier_list()
	_fill_divides_tier_list()


func _fill_today_correct_answers_labels() -> void:
	var today_multiplies = TodayCorrectAnswers.get_setting("correct_multiplies")
	var today_divides = TodayCorrectAnswers.get_setting("correct_divides")
	today_correct_multiplies_label.text = str(today_multiplies)
	today_correct_divides_label.text = str(today_divides)


func _fill_total_correct_multiplies_label() -> void:
	var max_value = AppSettings.get_setting("multiply_max_value")
	
	var total_correct_answers = 0
	
	for a in range(1, max_value+1):
		for b in range(1, max_value+1):
			var key = str(a, "x", b)
			var correct_answers = MultiplyMemory.get_setting(key)
			total_correct_answers += correct_answers
	
	total_correct_multiplies_label.text = str(total_correct_answers)


func _fill_total_correct_divides_label() -> void:
	var max_value = AppSettings.get_setting("divide_max_value")
	
	var total_correct_answers = 0
	
	for b in range(1, max_value+1):
		for answer in range(1, max_value+1):
			var a = answer * b
			var key = str(a, ":", b)
			var correct_answers = DivideMemory.get_setting(key)
			total_correct_answers += correct_answers
	
	total_correct_divides_label.text = str(total_correct_answers)


func _fill_multiplies_tier_list() -> void:
	var max_value = AppSettings.get_setting("multiply_max_value")
	
	var pairs: Dictionary = {}
	var best_correct_answers = 0
	
	for a in range(1, max_value+1):
		for b in range(1, max_value+1):
			var key = str(a, "x", b)
			var correct_answers = MultiplyMemory.get_setting(key)
			
			if correct_answers > best_correct_answers:
				best_correct_answers = correct_answers
			
			pairs[key] = correct_answers
	
	if best_correct_answers == 0:
		var error_label = Label.new()
		error_label.text = "Brak poprawnych mnożeń!"
		error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		multiplies_tier_list.add_child(error_label)
		return
	
	var sorted_keys : Array = pairs.keys()
	sorted_keys.sort_custom(_sort_by_key.bind(pairs))
	
	for key in sorted_keys:
		var bar = AnswerProgressBarLeft.instantiate()
		multiplies_tier_list.add_child(bar)
		bar.setup(key, pairs[key] / best_correct_answers)


func _fill_divides_tier_list() -> void:
	var max_value = AppSettings.get_setting("divide_max_value")
	
	var pairs: Dictionary = {}
	var best_correct_answers = 0
	
	for b in range(1, max_value+1):
		for answer in range(1, max_value+1):
			var a = answer * b
			var key = str(a, ":", b)
			var correct_answers = DivideMemory.get_setting(key)
			
			if correct_answers > best_correct_answers:
				best_correct_answers = correct_answers
			
			pairs[key] = correct_answers
	
	if best_correct_answers == 0:
		var error_label = Label.new()
		error_label.text = "Brak poprawnych dzieleń!"
		error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		divides_tier_list.add_child(error_label)
		return
	
	var sorted_keys: Array = pairs.keys()
	sorted_keys.sort_custom(_sort_by_key.bind(pairs))
	
	for key in sorted_keys:
		var bar = AnswerProgressBarRight.instantiate()
		divides_tier_list.add_child(bar)
		bar.setup(key, pairs[key] / best_correct_answers)


func _sort_by_key(a: String, b: String, dict: Dictionary) -> bool:
	return dict[a] > dict[b]
