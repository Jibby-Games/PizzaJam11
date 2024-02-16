extends Control

@export var next_scene := preload("res://levels/bar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	# Skip intro
	if event.is_pressed():
		go_to_game()


func go_to_game() -> void:
	get_tree().change_scene_to_packed(next_scene)
