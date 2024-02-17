extends Control

@export var next_scene := preload("res://levels/bar.tscn")

func _input(event: InputEvent) -> void:
	# Skip intro
	if event.is_pressed():
		go_to_game()


func go_to_game() -> void:
	get_tree().change_scene_to_packed(next_scene)
