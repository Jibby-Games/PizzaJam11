extends Area2D


@export var piss_embarrassment_penalty = 100
var frame_embarrassment = 0


func pissed_on(delta: float, _frame_piss: float) -> bool:
	frame_embarrassment = delta * piss_embarrassment_penalty
	return false


func embarrassment_impact(_piss: float) -> float:
	return frame_embarrassment
