extends Level


var events_done := 0
var total_events := 4


func check_spawn_door_trigger():
	if events_done >= total_events:
		print_debug("All events done, spawning door")
		$DoorTrigger.enable()


func _on_trigger_done():
	events_done += 1
	check_spawn_door_trigger()
