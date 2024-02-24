extends Node2D

## Display time is dynamically calculated from word length.
## Words per minute.
@export var wpm = 120

var follow_object: Object
@export var horizontal_offset = 0
@export var vertical_offset = -20

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Spawned a dialogue box!")
	var num_words = len($Label.text.split(" "))
	print("This dialoge box has %d words" % num_words)
	$Timer.wait_time = num_words / (wpm / 60.0)
	print("I will display for %s seconds" % $Timer.wait_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var offset = Vector2(horizontal_offset, vertical_offset)
	global_position = follow_object.global_position + offset
	global_rotation = 0


func set_text(text: String) -> void:
	$Label.text = text


func _on_timer_timeout():
	print("Timer ran out!")
	queue_free()
