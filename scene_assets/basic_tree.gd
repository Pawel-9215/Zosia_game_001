tool
extends Node2D

var tree_bases = [preload("res://scene_assets/tree_pieces/tree_base_01.tscn"),
preload("res://scene_assets/tree_pieces/tree_base_02.tscn"),
preload("res://scene_assets/tree_pieces/tree_base_03.tscn")]

var tree_mids = [preload("res://scene_assets/tree_pieces/tree_mid_01.tscn"),
preload("res://scene_assets/tree_pieces/tree_mid_02.tscn"),
preload("res://scene_assets/tree_pieces/tree_mid_03.tscn")]



func _ready():
	add_child(tree_bases[randi() % len(tree_bases)].instance())

	var base_joint_pos = get_node("tree_base/joint").position

	print(base_joint_pos)
	add_child(tree_mids[randi() % len(tree_mids)].instance())
	get_node("tree_mid").set_position(base_joint_pos)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
