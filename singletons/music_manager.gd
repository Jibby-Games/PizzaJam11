extends Node

@export var songs := {
	"sensual": "res://music/sensual jazz - grand project.mp3",
	"jazz": "res://music/a jazz piano - music for videos.mp3",
}

@onready
var player : AudioStreamPlayer = $MusicPlayer


func play_song(song_name: String) -> void:
	if song_name not in songs:
		push_error("that song doesn't exist! available: %p", songs.keys())
	player.stream = load(songs[song_name])
	player.play()
