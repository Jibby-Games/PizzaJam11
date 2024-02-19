extends Camera2D

#Based of the 3.x KidsCanCode implementation -> https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html

@export var decay := 0.8 #How quickly shaking will stop [0,1].
@export var max_offset := Vector2(100,75) #Maximum displacement in pixels.
@export var max_roll := 0.1 #Maximum rotation in radians (use sparingly).
@export var noise : FastNoiseLite #The source of random values.
## Controls the minimum trauma amount so screen can shake consistently
@export var min_trauma := 0.0

var noise_y = 0 #Value used to move through the noise

var trauma := 0.0 #Current shake strength
var trauma_pwr := 3 #Trauma exponent. Use [2,3]


func _ready():
	assert(noise)
	randomize()
	noise.seed = randi()

func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	trauma = max(trauma, min_trauma)
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
  #optional
	elif offset.x != 0 or offset.y != 0 or rotation != 0:
		lerp(offset.x,0.0,1)
		lerp(offset.y,0.0,1)
		lerp(rotation,0.0,1)

func shake():
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	# Hardcoded values for x coord as the noise gets worse far away from the origin when using the seed
	rotation = max_roll * amt * noise.get_noise_2d(10000,noise_y)
	var offset_x_noise := noise.get_noise_2d(0,noise_y)
	assert(offset_x_noise >= -1 and offset_x_noise <= 1, "noise value not within -1 to 1, I think this is a bug in the noise algorithm, try a different one")
	var offset_y_noise := noise.get_noise_2d(-10000,noise_y)
	assert(offset_y_noise >= -1 and offset_y_noise <= 1, "noise value not within -1 to 1, I think this is a bug in the noise algorithm, try a different one")
	offset.x = max_offset.x * amt * offset_x_noise
	offset.y = max_offset.y * amt * offset_y_noise
