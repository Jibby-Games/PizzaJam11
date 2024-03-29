extends Node


var levels := [
	preload("res://levels/PartyGame/arrival.tscn"),
	preload("res://levels/PartyGame/house0.tscn"),
	preload("res://levels/level1.tscn"),
	preload("res://levels/PartyGame/house1.tscn"),
	preload("res://levels/level2.tscn"),
	preload("res://levels/level3.tscn"),
	preload("res://levels/level4.tscn"),
	preload("res://levels/level5.tscn"),
	preload("res://levels/level6.tscn"),
	preload("res://levels/PartyGame/house2.tscn"),
	preload("res://ui/end_game.tscn"),
]

var current_level := 0

func load_first_level() -> void:
	current_level = 0
	change_to(levels[current_level])

func load_next_level() -> void:
	current_level += 1
	if current_level >= levels.size():
		print_debug("reached end of levels! you win?")
		return
	change_to(levels[current_level])


func change_to(next_level: PackedScene) -> void:
	assert(next_level, "next_level can't be null! Did something not set the level corectly?")
	# Defer it just in case something funky called this
	call_deferred("_do_the_change", next_level)


func _do_the_change(next_level: PackedScene) -> void:
	get_tree().change_scene_to_packed(next_level)


func restart() -> void:
	print("restarting the level")
	get_tree().reload_current_scene()
