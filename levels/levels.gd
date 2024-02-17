extends Node

func change_to(next_level: PackedScene) -> void:
	get_tree().change_scene_to_packed(next_level)
