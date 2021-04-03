extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hurtbox_area_entered(area):
	print("Got Hit!")
	$leaf_blow.restart()
	var incoming = global_position - area.global_position
	$destruction.direction.x = incoming.x
	$destruction.restart()
	$Hurtbox.queue_free()
	$Sprite.visible = false
	$DeathTimer.start()

func _on_Timer_timeout():
	queue_free()
