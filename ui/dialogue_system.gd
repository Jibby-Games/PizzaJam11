extends Control

var current_event: DialogueScenarioData
var awkwardness_level := 0

func load_event(event_data: DialogueScenarioData) -> void:
	assert(event_data)
	self.show()
	current_event = event_data
	%StoryText.text = current_event.event_text
	%ChoiceButton1.text = current_event.choice1
	%ChoiceButton2.text = current_event.choice2
	%ChoiceButton3.text = current_event.choice3
	$ChoiceScreen.show()
	$ResponseScreen.hide()


func _on_choice_button_1_pressed() -> void:
	show_response(current_event.response1)
	add_awkwardness(current_event.awkardness1)

func _on_choice_button_2_pressed() -> void:
	show_response(current_event.response2)
	add_awkwardness(current_event.awkardness2)

func _on_choice_button_3_pressed() -> void:
	show_response(current_event.response3)
	add_awkwardness(current_event.awkardness3)

func show_response(value: String) -> void:
	%ResponseLabel.text = value
	$ChoiceScreen.hide()
	$ResponseScreen.show()


func add_awkwardness(value: int) -> void:
	awkwardness_level += value
	$Awkwardness/AwkwardnessBar.value = awkwardness_level