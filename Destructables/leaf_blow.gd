extends CPUParticles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity_x_limit = 30
var going_right = true
var horizontal_force = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if going_right:
		gravity.x += horizontal_force
		if gravity.x > gravity_x_limit:
			going_right = false
	else:
		gravity.x -= horizontal_force
		if gravity.x < -gravity_x_limit:
			going_right = true
