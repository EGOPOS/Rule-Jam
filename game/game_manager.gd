extends Node

var transitions: int = 0
var deaths: int = 0
var start_time: int
var end_time: int

func get_statistics():
	return {
		"spend_time": snapped((end_time - start_time) / 1000.0, 1.0),
		"deaths": deaths,
		"transitions": transitions
	}
#var 
var music_playlist = [load("res://assets/JDSherbert - Minigame Music Pack - Beach Vibes.mp3"), load("res://assets/JDSherbert - Minigame Music Pack - Digital Waves.mp3")]

@onready var audio_player = $AudioStreamPlayer
var music_loop: int = 0

func _ready():
	play_music()
	audio_player.finished.connect(play_music)
	
func play_music():
	audio_player.stream = music_playlist[wrapi(music_loop, 0, music_playlist.size())]
	audio_player.play()
	music_loop += 1
