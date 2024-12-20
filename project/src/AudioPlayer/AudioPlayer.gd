extends Node

var _players: Dictionary = {}


func _ready() -> void:
	_create_player("click", "res://assets/audio/switch28.wav")


func play(key: String) -> void:
	_players[key].play()


func _create_player(key: String, track_path: String) -> void:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = load(track_path)
	add_child(player)
	_players[key] = player
