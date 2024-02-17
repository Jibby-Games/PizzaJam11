extends StaticBody2D

@export var broken: bool = false

var filled_volume = 0
var max_volume = 100

## Four sprites, from empty to full
@export var sprite_change_thresholds = [0, 25, 50, 75]
## At this fullness, the urinal will break
@export var break_threshold = 200


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

	if broken:
		is_valid = false

	if is_adjacent_to_occupied():
		is_valid = false

	return is_valid

func pissed_on(frame_piss: float) -> bool:
	print("Filled %d" % filled_volume)
	if filled_volume < max_volume:
		filled_volume += frame_piss

	if filled_volume >= break_threshold:
		# If it has passed the break threshold, but was previously NOT broken, play the breaking animation
		if !broken:
			print("Urinal broke!")
			# Play the breaking animation
			$AnimatedSprite2D.play("breaking")

		# Then, set broken to true. Prevents previous block being executed
		broken = true

	if !broken:
		# Update the fullness sprite, if necessary
		$AnimatedSprite2D.animation = "pissing"

		var i = 0
		for threshold in sprite_change_thresholds:
			if filled_volume > threshold:
				$AnimatedSprite2D.frame = i
			i += 1

	return is_valid_urinal()
