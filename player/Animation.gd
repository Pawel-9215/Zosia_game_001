extends Node2D


onready var player = get_parent()
var bored = false
var is_kicking = false
signal kick_finished

enum {
	MOVE,
	KICK,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	match player.state:
		MOVE:
			move_state()
		KICK:
			kick_state()
	

func move_state():
	animate_movement(player.velocity)
	
func kick_state():
	if bored:
		bored = false
	if not is_kicking:
		is_kicking = true
		$AnimationPlayer.play("Kick")
	else:
		pass
	
func action_finished():
	is_kicking = false
	$AnimationPlayer.stop()
	emit_signal("kick_finished")
	print("kick finished")

func animate_movement(velocity):
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	elif velocity.x >0:
		$AnimatedSprite.flip_h = false
		
	if velocity.x !=0 and velocity.y == 0:
		$AnimationPlayer.play("Run")
		bored = false
	elif velocity.y > 0:
		$AnimationPlayer.play("Descend")
		bored = false
	elif velocity.y < 0:
		$AnimationPlayer.play("Jump")
		bored = false
	elif abs(velocity.x) < 1 and abs(velocity.y) < 1:
		if not bored:
			$AnimationPlayer.play("Idle")
		if $IdleTimer.is_stopped() and not bored:
			$IdleTimer.start()
			# print("Idle timer restated")

func set_idle_anim():
	#print("setting new anim")
	randomize()
	var animations = ["Idle", "Wave", "LookAround"]
	var anim = animations[randi()%3]
	#print(anim)
	$AnimationPlayer.play(anim)

func _on_IdleTimer_timeout():
#	print("Bored")
	bored = true
