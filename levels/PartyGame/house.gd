extends Level


var completed_events = [false, false, false]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func is_true(b: bool) -> bool:
	return b


func check_spawn_door_trigger():
	for b in completed_events:
		if not b:
			print_debug("Event is false")
			return
	
	print_debug("Spawning door")
	$DoorTrigger.enable()


func _on_refreshments_trigger_trigger_done():
	print_debug("refreshments")
	completed_events[0] = true
	check_spawn_door_trigger()


func _on_cheese_trigger_trigger_done():
	print_debug("Cheese")
	completed_events[1] = true
	check_spawn_door_trigger()


func _on_host_awkward_trigger_trigger_done():
	print_debug("Host")
	completed_events[2] = true
	check_spawn_door_trigger()
