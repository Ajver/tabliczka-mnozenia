extends Control


@onready var a_label = %A_Label
@onready var b_label = %B_Label
@onready var answer_line_edit = %AnswerLineEdit
@onready var check_btn = %CheckBtn
@onready var question_generator = %QuestionGenerator


func _ready() -> void:
	answer_line_edit.text_submitted.connect(_check)
	check_btn.pressed.connect(_check)
	
	question_generator.generate_correctness_map(10000)
	
	_generate_next_question()


func _generate_next_question() -> void:
	var questions: Array[int] = question_generator.generate_next_question()
	
	a_label.text = str(questions[0])
	b_label.text = str(questions[1])
	
	answer_line_edit.text = ""


func _check(_v=null) -> void:
	var answer_text : String = answer_line_edit.text
	var answer_int : int = answer_text.to_int()
	var is_correct = question_generator.check(answer_int)
	
	if is_correct:
		# TODO: animation
		pass
	else:
		pass
	
	_generate_next_question()
