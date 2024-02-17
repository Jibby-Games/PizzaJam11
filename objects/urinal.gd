extends StaticBody2D

var filled_volume = 0
var max_volume = 100

# This will be added per frame, as the pissed_on function is called by things in the physics process
var fill_frame_delta = 1

# Four sprites, from empty to full
var sprite_change_thresholds = [0, 25, 50, 75]
var sprites = []


func is_occupied() -> bool:
	var adjacent_urinals = $UrinalCollision.get_overlapping_areas()
	for area in adjacent_urinals:
		if area.is_in_group("urinal_occupants"):
			print("Urinal with name %s has an occupant" % area.get_parent().name)
			return true
	return false

# Check for any occupied adjacent urinals
func is_adjacent_to_occupied() -> bool:
	var adjacent_urinals = $UrinalCollision.get_overlapping_areas()

	for area in adjacent_urinals:
		# Only check urinals
		if area.is_in_group("urinals"):
			var parent = area.get_parent()
			if parent.is_occupied():
				return true
	return false


func is_valid_urinal() -> bool:
	# If the urinal is occupied, it is ALWAYS invalid
	if is_occupied():
		return false

	# The default state will be valid. Check for reasons NOT to use this stall.
	var is_valid = true

	if is_adjacent_to_occupied():
		is_valid = false

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
