extends Area2D

# In case door is used for something else
#@export var next_scene : PackedScene

@export var is_enabled = true

func _ready():
	if is_enabled:
		enable()
	else:
		disable()
	

func _on_body_entered(_body: Node2D) -> void:
	if is_enabled:
		Levels.load_next_level()


func disable():
	is_enabled = false
	$CircleSprite.visible = false


func enable():
	is_enabled = true
	$CircleSprite.visible = true
