extends StaticBody2D

@export var occupied: bool = false

var filled_volume = 0
var max_volume = 100

# This will be added per frame, as the pissed_on function is called by things in the physics process
var fill_frame_delta = 1

# Four sprites, from empty to full
var sprite_change_thresholds = [0, 25, 50, 75]
var sprites = []


func is_valid_urinal() -> bool:
	var is_valid = false

	if !occupied:
		is_valid = true

	return is_valid

func pissed_on() -> bool:
	if filled_volume < max_volume:
		filled_volume += fill_frame_delta

	$AnimatedSprite2D.animation = "pissing"

	var i = 0
	for threshold in sprite_change_thresholds:
		if filled_volume > threshold:
			$AnimatedSprite2D.frame = i
		i += 1

	return is_valid_urinal()
