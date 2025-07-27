extends Node2D

@onready var player = get_tree().get_first_node_in_group('Player')
@onready var player_start_pos = player.global_position

func _process(delta: float) -> void:
	var moved = player.global_position - player_start_pos
	$"1".global_position = moved * .3
	$"2".global_position = moved * .5
	$"3".global_position = moved * .7
