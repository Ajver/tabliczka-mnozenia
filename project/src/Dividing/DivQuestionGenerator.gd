extends Node

var _question_a: int = -1
var _question_b: int = -1

var max_value: int = -1

var _previous_key = ""


func _ready() -> void:
	max_value = AppSettings.get_setting("divide_max_value")


func generate_next_question() -> Array[int]:
	var key: String = _previous_key
	var regenerate: bool = false
	
	while _previous_key == key or regenerate:
		_question_b = randi_range(1, max_value)
		var div_result = randi_range(1, max_value)
		_question_a = div_result * _question_b
		
		key = str(_question_a, "/", _question_b)
		
		if regenerate:
			# that's the regenerate. Let's not re-generate again
			regenerate = false
		else:
			regenerate = _should_regenerate(key)
	
	_previous_key = key
	
	return [_question_a, _question_b]


func get_current_question_answer() -> Array[int]:
	return [_question_a, _question_b, _question_a / _question_b]


func _should_regenerate(key: String) -> bool:
	var current = int(DivideMemory.get_setting(key))
	
	if current == 0:
		# No good answers yet. Let's pick that!
		return false
	
	var roll = randi() % current
	
	# The more good answers to this question, the less chance the roll < threshold
	# therefore the less chance we keep this answer
	var threshold = 3
	var should_keep = roll < threshold
	
	return not should_keep


func check(answer: int) -> bool:
	var expected = _question_a / _question_b
	
	if answer == expected:
		_correct_answer()
		return true
	else:
		_wrong_answer()
		return false


func _correct_answer() -> void:
	var key = str(_question_a, "/", _question_b)
	var current = DivideMemory.get_setting(key)
	current += 1
	DivideMemory.set_setting(key, current)
	
	print("Correct! (%d)" % current)


func _wrong_answer() -> void:
	var key = str(_question_a, "/", _question_b)
	var current = DivideMemory.get_setting(key)
	current = max(current -1, 0)
	DivideMemory.set_setting(key, current)

	print("Wrong... (%d)" % current)


func generate_correctness_map(total: int) -> Dictionary:
	var map = {}
	for i in range(total):
		var questions: Array[int] = generate_next_question()
		var key = str(questions[0], "/", questions[1])
		
		if not map.has(key):
			map[key] = 0
		
		map[key] += 1
	
	print(map)
	
	for key in map.keys():
		map[key] = map[key] * 100.0 / total
	
	print(map)
	return map
