extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide everything by default
	hide_all()

func show_ingame() -> void:
	hide_all()
	$Ingame.show()

func show_win() -> void:
	hide_all()
	$WinScreen/AnimationPlayer.play("showScreen")


func show_pissed_self() -> void:
	hide_all()
	$PissedSelfScreen/AnimationPlayer.play("showScreen")

func hide_all() -> void:
	for child in get_children():
		child.hide()

func update_bladder(value: float) -> void:
	$Ingame/Bladder.value = value

func update_awkwardness(value: float) -> void:
	$Ingame/Awkwardness.value = value
