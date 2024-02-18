extends Area2D


@export var piss_embarrassment_penalty = 100
var frame_embarrassment = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func pissed_on(delta: float, frame_piss: float) -> bool:
	frame_embarrassment = delta * piss_embarrassment_penalty
	return false


func embarrassment_impact(piss: float) -> float:
	return frame_embarrassment
