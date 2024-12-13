extends Control


@onready var a_label = %A_Label
@onready var b_label = %B_Label
@onready var answer_line_edit = %AnswerLineEdit
@onready var check_btn = %CheckBtn

var question_a: int = -1
var question_b: int = -1


func _ready() -> void:
	answer_line_edit.text_submitted.connect(_check)
	check_btn.pressed.connect(_check)
	
	_generate_next_question()


func _generate_next_question() -> void:
	question_a = randi_range(1, 10)
	question_b = randi_range(1, 10)
	
	a_label.text = str(question_a)
	b_label.text = str(question_b)
	
	answer_line_edit.text = ""


func _check(_v=null) -> void:
	var answer_text : String = answer_line_edit.text
	var answer_int : int = answer_text.to_int()
	var expected = question_a * question_b
	
	if answer_int == expected:
		_correct_answer()
	else:
		_wrong_answer()
	
	_generate_next_question()


func _correct_answer() -> void:
	print("Correct!")


func _wrong_answer() -> void:
	print("Wrong answer")
