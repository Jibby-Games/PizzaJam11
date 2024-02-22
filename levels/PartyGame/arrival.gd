extends Level


func _ready() -> void:
	UI.start_cinematic()
	$AnimationPlayer.play("intro")
	await $AnimationPlayer.animation_finished
	UI.end_cinematic()


func _on_taxi_awkward_trigger_trigger_done() -> void:
	$AnimationPlayer.play("taxi_drive_off")
