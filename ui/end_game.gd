extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	UI.hide_all()
	Music.play_song("sensual")
	var awkward_score := int(UI.total_awkwardness*100)
	print_debug("Awkward score was: %d", awkward_score)
	%score.text = "%d%%" % awkward_score
	if awkward_score < 100:
		%awkwardtext.text = "Wow, very impressive! Were you cheating???"
	elif awkward_score < 1000:
		%awkwardtext.text = "Not bad!"
	else:
		%awkwardtext.text = "Wow, you were pretty awkward, huh?"
