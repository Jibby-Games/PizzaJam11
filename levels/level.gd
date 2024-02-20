class_name Level extends Node2D

@export var level_name: String
## Optional track to play when the level starts - otherwise continues current song
@export var music_track: String
var wait_for_input := false
var done := false
var failed := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(not level_name.is_empty(), "You must give the level a name on the Level node!")
	assert($Player, "level must have a player parented to Level node!")
	UI.set_level_name(level_name)
	UI.show_ingame()
	if not music_track.is_empty():
		Music.play_song(music_track)
	$Player.connect("bladder_empty", level_done)
	$Player.connect("failure", level_failed)


func level_done() -> void:
	if done:
		return
	done = true
	print("level completed!")
	UI.show_win()
	wait_for_input = true


func level_failed(reason: String) -> void:
	if failed:
		return
	failed = true
	print("level failed!")
	UI.show_failure(reason)


func _input(event: InputEvent) -> void:
	if wait_for_input and event.is_pressed():
		Levels.load_next_level()
