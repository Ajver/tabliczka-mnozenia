extends Control

@onready var a_label = %A_Label
@onready var b_label = %B_Label
@onready var answer_line_edit = %AnswerLineEdit
@onready var check_btn = %CheckBtn
@onready var question_generator = %MulQuestionGenerator
@onready var correct_answer_popup = $CorrectAnswerPopup
@onready var wrong_answer_popup = $WrongAnswerPopup

# Used when animation is playing
var _ignore_input: bool = false


func _ready() -> void:
	answer_line_edit.text_submitted.connect(_check)
	check_btn.pressed.connect(_check)
	
	correct_answer_popup.animation_end.connect(_on_animation_ended)
	wrong_answer_popup.animation_end.connect(_on_animation_ended)
	
	question_generator.generate_correctness_map(10000)
	
	_generate_next_question()


func _generate_next_question() -> void:
	var questions: Array[int] = question_generator.generate_next_question()
	
	a_label.text = str(questions[0])
	b_label.text = str(questions[1])
	
	answer_line_edit.text = ""


func _check(_v=null) -> void:
	if _ignore_input:
		return
	
	var answer_text : String = answer_line_edit.text
	
	if answer_text.strip_edges() == "":
		# No text input
		return
	
	var answer_int : int = answer_text.to_int()
	var is_correct = question_generator.check(answer_int)
	
	_ignore_input = true
	
	if is_correct:
		correct_answer_popup.play()
	else:
		var current_answer = question_generator.get_current_question_answer()
		wrong_answer_popup.play(current_answer[0], current_answer[1], current_answer[2], "multiply")


func _on_animation_ended() -> void:
	_ignore_input = false
	
	_generate_next_question()
