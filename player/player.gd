extends CharacterBody2D

var speed = 400  # move speed in pixels/sec
var is_pissing = false

var current_piss_volume = 1000
var min_piss_volume = 0
var max_piss_volume = 2000

var current_missed_piss = 0
var max_missed_piss = 250

# per physics frame
var pissing_delta = 2
var piss_buildup_delta = 1


func _physics_process(delta):
	look_at(get_global_mouse_position())
	var move_input = Input.get_vector("left", "right", "up", "down")

	if move_input.is_zero_approx():
		$BodySpriteAnim.play("idle")
	else:
		$BodySpriteAnim.play("walking")

	velocity = move_input * speed
	move_and_slide()

	if is_pissing:
		check_piss()
	else:
		not_pissing()

	# Check that the player has not wet themselves
	if current_piss_volume >= max_piss_volume:
		wet_self()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("piss"):
		start_piss()

	if event.is_action_released("piss"):
		stop_piss()


func wet_self() -> void:
	print("The player has reached max capacity!")
	pass


func not_pissing() -> void:
	current_piss_volume += piss_buildup_delta


func start_piss() -> void:
	if current_piss_volume > 0:
		$PissParticles.emitting = true
		is_pissing = true


func stop_piss() -> void:
	$PissParticles.emitting = false
	is_pissing = false


func check_piss() -> void:
	if current_piss_volume > 0:
		current_piss_volume -= pissing_delta

		# Check for piss targets
		var is_valid_piss = false
		if $PissRaycast.is_colliding():
			var obj: Object = $PissRaycast.get_collider()
			if obj.has_method("pissed_on"):
				is_valid_piss = obj.pissed_on()
			
		process_piss(is_valid_piss)

	else:
		stop_piss()
		empty_bladder()


func empty_bladder() -> void:
	print("Bladder is empty!")
	UI.show_win()


func process_piss(valid: bool) -> void:
	if valid:
		print("This is a valid target!")
	else:
		current_missed_piss += pissing_delta
	
	if current_missed_piss >= max_missed_piss:
		print("The player pissed themselves")
		is_pissing = false
		UI.show_win()

