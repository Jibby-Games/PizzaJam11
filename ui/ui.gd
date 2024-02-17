extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide everything by default
	hide_all()

func show_ingame() -> void:
	hide_all()

func show_win() -> void:
	$WinScreen/AnimationPlayer.play("showScreen")


func show_pissed_self() -> void:
	$PissedSelfScreen/AnimationPlayer.play("showScreen")

func hide_all() -> void:
	for child in get_children():
		child.hide()
