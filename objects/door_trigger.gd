extends Area2D

# In case door is used for something else
#@export var next_scene : PackedScene


func _on_body_entered(_body: Node2D) -> void:
	Levels.load_next_level()
