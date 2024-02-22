extends Level


func _ready() -> void:
	UI.start_cinematic()
	$AnimationPlayer.play("intro")
	await $AnimationPlayer.animation_finished
	UI.end_cinematic()
