extends CanvasLayer

var dialogue_wpm = 120
var ui_savestate = []
var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AwkwardEventSystem.player_portrait_head = $PlayerPortrait/Head
	# Hide everything by default
	hide_all()

func show_ingame() -> void:
	hide_all()
	$Ingame.show()
	$PlayerPortrait.show()
	$Awkwardness.show()

func show_win() -> void:
	hide_all()
	$WinScreen/AnimationPlayer.play("showScreen")


func show_failure(reason: String) -> void:
	$PissedSelfScreen/Reason.text = reason
	hide_all()
	$PissedSelfScreen/AnimationPlayer.play("showScreen")

func hide_all() -> void:
	ui_savestate = {}
	for child in get_children():
		ui_savestate[child.get_instance_id()] = child.visible
		child.hide()

func restore_savestate() -> void:
	var children = get_children()
	for child in children:
		child.visible = ui_savestate[child.get_instance_id()]

func freeze_player() -> void:
	if is_instance_valid(player):
		player.freeze()

func unfreeze_player() -> void:
	if is_instance_valid(player):
		player.unfreeze()

func update_bladder(value: float) -> void:
	$Ingame/Bladder.value = value

func update_awkwardness(value: float) -> void:
	$Awkwardness/AwkwardnessBar.value = value
	if value > 30.0:
		if $Awkwardness/AnimationPlayer.current_animation != "awks":
			$Awkwardness/AnimationPlayer.play("awks")
		$Awkwardness/AnimationPlayer.speed_scale = 0.5 + value / 100.0
	elif value > 60.0:
		if $Awkwardness/AnimationPlayer.current_animation != "mega_awks":
			$Awkwardness/AnimationPlayer.play("mega_awks")
		$Awkwardness/AnimationPlayer.speed_scale = 2 + value / 100.0
	else:
		$Awkwardness/AnimationPlayer.stop()
	$PlayerPortrait.set_sweat_level(value / 100.0)

func add_awkwardness(value: float) -> void:
	player.current_embarrassment += value
	update_awkwardness(player.current_embarrassment)


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

func load_awkward_scenario(scenario: AwkwardScenarioData) -> Control:
	freeze_player()
	$PlayerPortrait.show()
	$Awkwardness.show()
	return $AwkwardEventSystem.load_event(scenario)

func _on_dialogue_box_timeout_timeout():
	close_dialogue()

func _on_awkward_event_system_event_finished():
	unfreeze_player()
