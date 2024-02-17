class_name Player extends CharacterBody2D

var speed = 400  # move speed in pixels/sec
var is_pissing = false

@export var current_piss_volume = 40.0
@export var min_piss_volume = 0.0
@export var max_piss_volume = 100.0

var current_missed_piss = 0.0
@export var max_missed_piss = 20.0

var current_embarrassment = 0
var miss_piss_embarrassment_penalty = 30

# per second
var pissing_delta = 10
var piss_buildup_delta = 1

signal bladder_empty
signal failure(reason: String)


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

	update_embarrassment()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("piss"):
		start_piss()

	if event.is_action_released("piss"):
		stop_piss()

	if event.is_action_pressed("restart"):
		Levels.restart()


## TODO: Have a proximity collider, and each node in that area should report any closeness embarrassment contributions
func update_embarrassment() -> void:
	print_debug("Current embarrassment is now %f" % current_embarrassment)


func wet_self() -> void:
	$ShakeCamera2D.add_trauma(0.5)
	print("The player has reached max capacity!")
	failure.emit("wet self")


func not_pissing(delta) -> void:
	current_piss_volume += (piss_buildup_delta * delta)


func start_piss() -> void:
	if current_piss_volume > 0:
		print_debug("started pissing")
		$PissParticles.emitting = true
		is_pissing = true
		$ShakeCamera2D.add_trauma(0.1)


func stop_piss() -> void:
	print_debug("stopped pissing")
	$PissParticles.emitting = false
	is_pissing = false


func check_piss(delta) -> void:
	if current_piss_volume > 0:
		var frame_piss = pissing_delta * delta
		current_piss_volume -= frame_piss

		# Check for piss targets
		var is_valid_piss = false
		var frame_embarrassment_increment = 0
		if $PissRaycast.is_colliding():
			var obj: Object = $PissRaycast.get_collider()
			if obj.has_method("pissed_on"):
				is_valid_piss = obj.pissed_on(delta, frame_piss)
			else:
				print_debug("Pissed on an object which doesn't have a 'pissed_on' method")
			if obj.has_method("embarrassment_impact"):
				frame_embarrassment_increment += obj.embarrassment_impact(frame_piss)
			else:
				print_debug("Pissed on an object which doesn't have an 'embarrassment_impact' method")
		else:
			# If you don't hit any target, you pay a penalty for missing
			frame_embarrassment_increment += miss_piss_embarrassment_penalty * delta

		process_piss(delta, is_valid_piss)

	else:
		stop_piss()
		empty_bladder()


func empty_bladder() -> void:
	print("Bladder is empty!")
	bladder_empty.emit()


func process_piss(delta: float, valid: bool) -> void:
	if valid:
		pass
	else:
		current_missed_piss += (pissing_delta * delta)

	if current_missed_piss >= max_missed_piss:
		print("The player pissed themselves")
		$ShakeCamera2D.add_trauma(0.5)
		is_pissing = false
		failure.emit("missed too much")
