extends Control

var current_event: AwkwardScenarioData
var awkwardness_level := 0
var wait_for_accept := false

signal event_finished()

func load_event(event_data: AwkwardScenarioData) -> void:
	assert(event_data)
	self.show()
	current_event = event_data
	%StoryText.text = current_event.event_text
	%ChoiceButton1.text = current_event.choice_1
	%ChoiceButton2.text = current_event.choice_2
	%ChoiceButton3.text = current_event.choice_3
	$ChoiceScreen.show()
	$ResponseScreen.hide()
	
	$PlayerPortrait/Head.animation = current_event.player_animation
	if current_event.playertalk_scenario:
		$PlayerPortrait/Head.play()
	else:
		$PlayerPortrait/Head.stop()
	
	$NPCPortrait/Head.animation = current_event.npc_animation
	if current_event.npctalk_scenario:
		$NPCPortrait/Head.play()
	else:
		$NPCPortrait/Head.stop()

func _input(event: InputEvent) -> void:
	if wait_for_accept and event.is_action_pressed("ui_accept"):
		self.hide()
		emit_signal("event_finished")
		wait_for_accept = false

func _on_choice_button_1_pressed() -> void:
	show_response(current_event.response_1, current_event.player_talk1, current_event.npc_talk_1)
	add_awkwardness(current_event.awkardness_1)

func _on_choice_button_2_pressed() -> void:
	show_response(current_event.response_2, current_event.player_talk_2, current_event.npc_talk_2)
	add_awkwardness(current_event.awkardness_2)

func _on_choice_button_3_pressed() -> void:
	show_response(current_event.response_3, current_event.player_talk_3, current_event.npc_talk_3)
	add_awkwardness(current_event.awkardness_3)

func show_response(
	value: String, 
	player_talks: bool, 
	npc_talks: bool, 
	player_animation: String = "", 
	npc_animation: String = ""
) -> void:
	%ResponseLabel.text = value
	$ChoiceScreen.hide()
	$ResponseScreen.show()
	
	if player_animation != "":
		$PlayerPortrait/Head.animation = player_animation
		
	if npc_animation != "":
		$NPCPortrait/Head.animation = npc_animation
	
	if player_talks:
		$PlayerPortrait/Head.play()
	else:
		$PlayerPortrait/Head.stop()
	
	if npc_talks:
		$NPCPortrait/Head.play()
	else:
		$NPCPortrait/Head.stop()

	wait_for_accept = true


func add_awkwardness(value: int) -> void:
	awkwardness_level += value
	$Awkwardness/AwkwardnessBar.value = awkwardness_level
	$PlayerPortrait.set_sweat_level(awkwardness_level / 100.0)
