extends Control

func _ready() -> void:
	Music.play_song("sensual")

func _input(event: InputEvent) -> void:
	# Start the levels on any input
	if event.is_pressed():
		Levels.load_first_level()
