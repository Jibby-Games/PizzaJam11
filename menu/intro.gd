extends Control

@export var next_scene: PackedScene

func _input(event: InputEvent) -> void:
	# Skip intro
	if event.is_pressed():
		go_to_game()


func go_to_game() -> void:
	assert(next_scene)
	get_tree().change_scene_to_packed(next_scene)
