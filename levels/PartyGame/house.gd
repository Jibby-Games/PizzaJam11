extends Level


var completed_events = [false, false, false]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_refreshments_trigger_trigger_done():
	completed_events[0] = true


func _on_cheese_trigger_trigger_done():
	completed_events[1] = true


func _on_host_awkward_trigger_trigger_done():
	completed_events[2] = true


func check_
