extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide everything by default
	for child in get_children():
		child.hide()
	$Label.show()


func show_win() -> void:
	$WinScreen.show()
