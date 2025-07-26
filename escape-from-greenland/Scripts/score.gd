extends Node2D

@onready var cam = get_tree().get_first_node_in_group('Cam')

var score = 0

func _process(delta: float) -> void:
	global_position = cam.global_position
	
func increase_score(amount:int):
	score += amount
	$AnimCont/Score.text = "Score: " + str(score)
	$AnimationPlayer.play('Score')
