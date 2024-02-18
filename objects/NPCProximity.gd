extends Area2D


var DIALOGUE_SCENE = preload("res://objects/DialogueBox.tscn")

var dialogue_instance

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


func _on_body_entered(body):
	set_text("I see you!")


func _on_body_exited(body):
	set_text("Where did you go?")
