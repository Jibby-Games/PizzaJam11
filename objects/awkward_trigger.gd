extends Area2D

@export var awkward_scenario : AwkwardScenarioData

func _on_body_entered(body: Node2D) -> void:
	assert(awkward_scenario, "you need to add the scenario data to the trigger silly!")
	UI.load_awkward_scenario(awkward_scenario)
