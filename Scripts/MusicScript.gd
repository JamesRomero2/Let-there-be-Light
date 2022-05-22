extends Node

var background_music = load("res://assets/audio files/Music/BG_Music.ogg")

func play_music():
	$Music.stream = background_music
	$Music.play()
