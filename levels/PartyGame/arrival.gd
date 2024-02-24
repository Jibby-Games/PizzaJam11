extends Level


var DOOR_TRIGGER = preload("res://objects/door_trigger.tscn")


func _ready() -> void:
	super._ready()
	UI.start_cinematic()
	$AnimationPlayer.play("intro")
	await $AnimationPlayer.animation_finished
	UI.end_cinematic()


func _on_taxi_awkward_trigger_trigger_done() -> void:
	$AnimationPlayer.play("taxi_drive_off")


func _on_enter_house_awkward_trigger_trigger_done():
	Levels.load_next_level()
