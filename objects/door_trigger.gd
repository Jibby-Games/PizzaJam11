extends Area2D

@export var next_scene : PackedScene

func _on_body_entered(_body: Node2D) -> void:
	Levels.change_to(next_scene)
