extends Node2D

@onready var cam = get_tree().get_first_node_in_group('Cam')
@onready var player = get_tree().get_first_node_in_group('Player')

func _ready() -> void:
	player.hurt.connect(damage)

var score = 0

func _process(delta: float) -> void:
	if is_instance_valid(cam):
		global_position = cam.global_position
	
func increase_score(amount:int):
	score += amount
	$AnimCont/Score.text = "Score: " + str(score)
	$AnimationPlayer.play('Score')
	
func damage(health:int):
	$HealthAnim.play("hurt")
	$Health/Health.text = "Health: " + str(health)
