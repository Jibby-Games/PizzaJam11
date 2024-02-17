extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide everything by default
	for child in get_children():
		child.hide()


func show_win() -> void:
	$WinScreen.show()
