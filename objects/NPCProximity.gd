extends Area2D

var DIALOGUE_SCENE = preload("res://objects/DialogueBox.tscn")
var dialogue_instance

var num_entered = 0
var num_exited = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


## Spawn a text box object containing the text
func set_text(text: String) -> void:
	# If a dialogue box already exists, delete it
	if is_instance_valid(dialogue_instance):
		dialogue_instance.queue_free()

	dialogue_instance = DIALOGUE_SCENE.instantiate()
	dialogue_instance.follow_object = self
	dialogue_instance.set_text(text)

	get_parent().get_parent().add_child(dialogue_instance)


func get_rand_element(array: PackedStringArray) -> String:
	return array[randi() % array.size()]


func _on_body_entered(body):
	var options = get_parent().entered_text_array
	if options.size() <= 0:
		# No dialogue on this guy :(
		return
	var this_text = ""
	if get_parent().entered_text_random:
		this_text = get_rand_element(options)
	else:
		this_text = options[num_entered % len(options)]

	set_text(this_text)
	num_entered += 1


func _on_body_exited(body):
	var options = get_parent().exited_text_array
	if options.size() <= 0:
		# No dialogue on this guy :(
		return
	var this_text = ""
	if get_parent().exited_text_random:
		this_text = get_rand_element(options)
	else:
		this_text = options[num_exited % len(options)]

	set_text(this_text)
	num_exited += 1
