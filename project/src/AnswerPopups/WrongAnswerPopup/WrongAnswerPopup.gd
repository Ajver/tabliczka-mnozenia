extends Control

signal animation_end

@onready var multiply_sign: Control = %MultiplySign
@onready var divide_sign: Control = %DivideSign
@onready var correct_a_label: Label = %CorrectA
@onready var correct_b_label: Label = %CorrectB
@onready var correct_result_label: Label = %CorrectResult
@onready var continue_btn: Button = %ContinueBtn
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hide()
	continue_btn.pressed.connect(_continue)


func play(correct_a: int, correct_b: int, correct_result: int, operation: String) -> void:
	correct_a_label.text = str(correct_a)
	correct_b_label.text = str(correct_b)
	correct_result_label.text = str(correct_result)
	
	if operation == "multiply":
		multiply_sign.show()
		divide_sign.hide()
	else:
		multiply_sign.hide()
		divide_sign.show()
	
	show()
	
	animation_player.play("fade_in")


func _continue() -> void:
	animation_end.emit()
	hide()
