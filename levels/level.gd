class_name Level extends Node2D

@export var next_level: PackedScene

var wait_for_input := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI.show_ingame()
	$Player.connect("bladder_empty", level_done)

func level_done() -> void:
	UI.show_win()
	wait_for_input = true

func restart_level() -> void:
	get_tree

func _input(event: InputEvent) -> void:
	if wait_for_input and event.is_pressed():
		Levels.change_to(next_level)


