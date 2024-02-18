class_name Level extends Node2D

var wait_for_input := false
var done := false
var failed := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert($Player, "level must have a player parented to Level node!")
	UI.show_ingame()
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
