extends CanvasLayer


var dialogue_wpm = 80

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


func show_failure(reason: String) -> void:
	$PissedSelfScreen/Reason.text = reason
	hide_all()
	$PissedSelfScreen/AnimationPlayer.play("showScreen")

func hide_all() -> void:
	for child in get_children():
		child.hide()

func update_bladder(value: float) -> void:
	$Ingame/Bladder.value = value

func update_awkwardness(value: float) -> void:
	$Ingame/Awkwardness.value = value

func set_level_name(text: String) -> void:
	$Ingame/LevelName.text = text


func show_dialogue(text: String) -> void:
	$DialogueBox/Text.text = text
	$DialogueBox.visible = true

	var expiry_time = len(text.split(" ")) * 60 / dialogue_wpm
	$DialogueBox/DialogueBoxTimeout.wait_time = expiry_time
	$DialogueBox/DialogueBoxTimeout.start()

func close_dialogue() -> void:
	$DialogueBox/Text.text = ""
	$DialogueBox.visible = false

func load_awkward_scenario(scenario: AwkwardScenarioData) -> void:
	$AwkwardEventSystem.load_event(scenario)

func _on_dialogue_box_timeout_timeout():
	close_dialogue()
