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
	%ChoiceButton1.text = current_event.choice1
	%ChoiceButton2.text = current_event.choice2
	%ChoiceButton3.text = current_event.choice3
	$ChoiceScreen.show()
	$ResponseScreen.hide()
	
	if current_event.playertalk_scenario:
		$PlayerHead.play()
	else:
		$PlayerHead.stop()
	
	$NPCHead.animation = current_event.npc_animation
	if current_event.npctalk_scenario:
		$NPCHead.play()
	else:
		$NPCHead.stop()

func _input(event: InputEvent) -> void:
	if wait_for_accept and event.is_action_pressed("ui_accept"):
		self.hide()
		emit_signal("event_finished")
		wait_for_accept = false

func _on_choice_button_1_pressed() -> void:
	show_response(current_event.response1, current_event.playertalk1, current_event.npctalk1)
	add_awkwardness(current_event.awkardness1)

func _on_choice_button_2_pressed() -> void:
	show_response(current_event.response2, current_event.playertalk2, current_event.npctalk2)
	add_awkwardness(current_event.awkardness2)

func _on_choice_button_3_pressed() -> void:
	show_response(current_event.response3, current_event.playertalk3, current_event.npctalk3)
	add_awkwardness(current_event.awkardness3)

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
		$PlayerHead.animation = player_animation
		
	if npc_animation != "":
		$NPCHead.animation = npc_animation
	
	if player_talks:
		$PlayerHead.play()
	else:
		$PlayerHead.stop()
	
	if npc_talks:
		$NPCHead.play()
	else:
		$NPCHead.stop()

	wait_for_accept = true


func add_awkwardness(value: int) -> void:
	awkwardness_level += value
	$Awkwardness/AwkwardnessBar.value = awkwardness_level
	$PlayerPortrait.set_sweat_level(awkwardness_level / 100.0)
