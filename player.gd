extends "res://player/PlayerBaseClass.gd"

var velocity = Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity = handle_input()
	move_and_slide(velocity)

func handle_input():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("go_right") - Input.get_action_strength("go_left")
	return input_vector*SPEED
	
	

