extends CharacterBody2D

var speed = 400  # move speed in pixels/sec
var is_pissing = false

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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("piss"):
		start_piss()
		
	if event.is_action_released("piss"):
		stop_piss()

func start_piss() -> void:
	$PissParticles.emitting = true
	is_pissing = true

func stop_piss() -> void:
	$PissParticles.emitting = false
	is_pissing = false

func check_piss() -> void:
	if $PissRaycast.is_colliding():
		var obj : Object = $PissRaycast.get_collider()
		if obj.has_method("pissed_on"):
			obj.pissed_on()
