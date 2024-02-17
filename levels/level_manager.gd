extends Node

func change_to(next_level: PackedScene) -> void:
	call_deferred("_do_the_change", next_level)

func _do_the_change(next_level: PackedScene) -> void:
	get_tree().change_scene_to_packed(next_level)

func restart() -> void:
	get_tree().reload_current_scene()
