extends "res://player/PlayerBaseClass.gd"

const UP = Vector2(0,-1)

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

var extra_jump_time = true # is player is allowed to jump after fall
enum {
	MOVE,
	KICK,
} # these are the states for mini states machine 
var state = MOVE

func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	match state:  # applied state mashine
		MOVE:
			move_state()
		KICK:
			kick_state()
	
func move_state():  # function stack for moving state - default state
	apply_gravity()
	handle_jump()
	handle_action()
	handle_input()
	update_movement()
	jump_timer()
	velocity = move_and_slide(velocity, UP)
	printout_debug()

func kick_state():  # kick state
	apply_gravity()
	#handle_jump()
	#handle_action()
	#update_movement()
	#jump_timer()
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	velocity = move_and_slide(velocity, UP)
	printout_debug()
	
func kick_moment():
	if $KickArea/CollisionShape2D.disabled == true:
		$KickArea/CollisionShape2D.disabled = false

func handle_input():
	var internal_input_vector = Vector2.ZERO
	internal_input_vector.x = Input.get_action_strength("go_right") - Input.get_action_strength("go_left")
	input_vector = internal_input_vector
	
func handle_action():
	if Input.is_action_pressed("Action") and is_on_floor():
		state = KICK
	
func update_movement():
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
		$JumpTimer.stop()

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


func _on_Animation_kick_finished():
	$KickArea/CollisionShape2D.disabled = true
	state = MOVE
