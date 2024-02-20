extends Control

var sweat_level := 0.0
var max_particles := 100

## Sweat intensity between 0.0 and 1.0, but can go higher (not too much or it looks stupid)
func set_sweat_level(amount: float) -> void:
	sweat_level = amount
	$SweatParticles.emitting = (not is_zero_approx(sweat_level))
	var particles := ((2 ** sweat_level) - 1)  * max_particles
	$SweatParticles.amount = clampi(particles, 0, 1000000)
