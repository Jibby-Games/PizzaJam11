extends StaticBody2D

@export var broken: bool = false

## The current amount in the procelain
@export var filled_volume = 0

# TODO: We should have a specific sprite for a FULL urinal? Or just break them?
@export var max_volume = 50

## Four sprites, from empty to full
@export var sprite_change_thresholds = [0, 5, 20, 30]
## Controls if break threshold used
@export var breakable := false
## At this fullness, the urinal will break
@export var break_threshold = 5

## Per second
@export var on_target_piss_embarrassment = -10
@export var broken_urinal_embarrassment = 35
@export var broken_usage_embarrassment = 35
@export var occupied_usage_embarrassment = 200
@export var adjacent_usage_embarrassment = 80

var frame_embarrassment = 0


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

	return is_valid


func pissed_on(delta: float, frame_piss: float) -> bool:
	frame_embarrassment = 0

	if filled_volume < max_volume:
		filled_volume += frame_piss

	if breakable and filled_volume >= break_threshold:
		# If it has passed the break threshold, but was previously NOT broken, play the breaking animation
		if !broken:
			frame_embarrassment += broken_urinal_embarrassment
			trigger_breakage()

		# Then, set broken to true. Prevents previous block being executed
		broken = true

	if !broken:
		frame_embarrassment += on_target_piss_embarrassment * delta
		# Update the fullness sprite, if necessary
		$AnimatedSprite2D.animation = "pissing"

		var i = 0
		for threshold in sprite_change_thresholds:
			if filled_volume > threshold:
				$AnimatedSprite2D.frame = i
			i += 1
	else:
		# Continuing to piss in a broken urinal is pretty embarrassing
		frame_embarrassment += delta * broken_usage_embarrassment

	if is_occupied():
		frame_embarrassment += delta * occupied_usage_embarrassment

	if is_adjacent_to_occupied():
		frame_embarrassment += delta * adjacent_usage_embarrassment

	return is_valid_urinal()


func trigger_breakage() -> void:
	print("Urinal broke!")
	# Play the breaking animation
	$AnimatedSprite2D.play("breaking")
	$SmashSound.play()

func embarrassment_impact(piss: float) -> float:
	return frame_embarrassment
