extends CharacterBody2D

var speed = 400  # move speed in pixels/sec

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var move_input = Input.get_vector("left", "right", "up", "down")
	if move_input.is_zero_approx():
		$BodySpriteAnim.play("idle")
	else:
		$BodySpriteAnim.play("walking")
	velocity = move_input * speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("piss"):
		start_piss()
	if event.is_action_released("piss"):
		stop_piss()

func start_piss() -> void:
	$PissParticles.emitting = true

func stop_piss() -> void:
	$PissParticles.emitting = false
