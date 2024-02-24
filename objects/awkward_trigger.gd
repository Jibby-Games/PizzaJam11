extends Area2D

@export var awkward_scenario : AwkwardScenarioData
var triggered := false

# Emitted when the awkward event has finished - used so the level can connect other events to it like animations
signal trigger_done

func _on_body_entered(body: Node2D) -> void:
	assert(awkward_scenario, "you need to add the scenario data to the trigger silly!")
	if triggered:
		# Stop multiple triggers
		return
	triggered = true
	var awkward_interface = UI.load_awkward_scenario(awkward_scenario)
	awkward_interface.connect("event_finished", event_finished)

func event_finished() -> void:
	trigger_done.emit()
	queue_free()
