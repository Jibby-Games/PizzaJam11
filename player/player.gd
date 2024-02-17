class_name Player extends CharacterBody2D

var speed = 400  # move speed in pixels/sec
var is_pissing = false

var current_piss_volume = 50.0
var min_piss_volume = 0.0
var max_piss_volume = 2000.0

var current_missed_piss = 0.0
var max_missed_piss = 50.0

# per second
var pissing_delta = 10
var piss_buildup_delta = 1

signal bladder_empty


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
		check_piss(delta)
	else:
		not_pissing(delta)

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


func not_pissing(delta) -> void:
	current_piss_volume += (piss_buildup_delta * delta)


func start_piss() -> void:
	if current_piss_volume > 0:
		$PissParticles.emitting = true
		is_pissing = true


func stop_piss() -> void:
	$PissParticles.emitting = false
	is_pissing = false


func check_piss(delta) -> void:
	if current_piss_volume > 0:
		current_piss_volume -= (pissing_delta * delta)

		# Check for piss targets
		var is_valid_piss = false
		if $PissRaycast.is_colliding():
			var obj: Object = $PissRaycast.get_collider()
			if obj.has_method("pissed_on"):
				is_valid_piss = obj.pissed_on()

		process_piss(delta, is_valid_piss)

	else:
		stop_piss()
		empty_bladder()


func empty_bladder() -> void:
	print("Bladder is empty!")
	bladder_empty.emit()


func process_piss(delta: float, valid: bool) -> void:
	if valid:
		print("This is a valid target!")
	else:
		current_missed_piss += (pissing_delta * delta)

	if current_missed_piss >= max_missed_piss:
		print("The player pissed themselves")
		is_pissing = false
		UI.show_win()
