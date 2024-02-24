extends Level


var completed_events = [false, false, false]


func check_spawn_door_trigger():
	for b in completed_events:
		if not b:
			print_debug("Event is false")
			return
	
	print_debug("Spawning door")
	$DoorTrigger.enable()


func _on_host_awkward_trigger_trigger_done():
	completed_events[0] = true
	check_spawn_door_trigger()


func _on_dog_2_awkward_trigger_trigger_done():
	completed_events[1] = true
	check_spawn_door_trigger()


func _on_awkward_trigger_trigger_done():
	completed_events[2] = true
	check_spawn_door_trigger()
