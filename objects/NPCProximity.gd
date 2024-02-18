extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_text(text: String) -> void:
	$"../RemoteTransform2D/Reason".text = text


func _on_body_entered(body):
	set_text("I see you!")


func _on_body_exited(body):
	set_text("Where did you go?")
