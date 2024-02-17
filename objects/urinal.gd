extends StaticBody2D

var filled_volume = 0
var max_volume = 100

# This will be added per frame, as the pissed_on function is called by things in the physics process
var fill_frame_delta = 1 

# Four sprites, from empty to full
var sprite_change_thresholds = [0, 25, 50, 75]
var sprites = []

func pissed_on() -> void:
	if filled_volume < max_volume:
		filled_volume += fill_frame_delta

	$AnimatedSprite2D.animation = "pissing"

	var i = 0
	for threshold in sprite_change_thresholds:
		if filled_volume > threshold:
			$AnimatedSprite2D.frame = i
		i += 1

