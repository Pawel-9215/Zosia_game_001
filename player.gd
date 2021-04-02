extends "res://player/PlayerBaseClass.gd"

const UP = Vector2(0,-1)

var velocity = Vector2.ZERO
var extra_jump_time = true # is player is allowed to jump after fall
enum {
	MOVE,
	KICK,
}
var state = MOVE

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	match state:
		MOVE:
			move_state()
		KICK:
			kick_state()
	
func move_state():
	apply_gravity()
	handle_jump()
	update_movement()
	jump_timer()
	velocity = move_and_slide(velocity, UP)
	printout_debug()

func kick_state():
	pass

func handle_input():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("go_right") - Input.get_action_strength("go_left")
	return input_vector
	
func update_movement():
	var input_vector = handle_input()
	if  input_vector != Vector2.ZERO:
		velocity.x = move_toward(velocity.x, input_vector.x*SPEED, ACCELERATION)
	else:
		if velocity.x > 1 or velocity.x < -1:
			velocity.x = move_toward(velocity.x, 0, FRICTION)
		else:
			velocity.x = 0

func handle_jump():
	if Input.is_action_pressed("jump") and (is_on_floor() or extra_jump_time):
		velocity.y = JUMP_SPEED
		extra_jump_time = false

func printout_debug():
	$DebugLabel.text = str(velocity)
	
func apply_gravity():
	if is_on_floor() and velocity.y >= 0:
		velocity.y = 0
	elif is_on_ceiling():
		velocity.y = 10
	else:
		velocity.y += GRAVITY
		
func jump_timer():
	if is_on_floor() and (extra_jump_time == false):
		extra_jump_time = true
	elif (not is_on_floor()) and extra_jump_time and $JumpTimer.is_stopped():
		$JumpTimer.start()
	
	



func _on_JumpTimer_timeout():
	extra_jump_time = false
