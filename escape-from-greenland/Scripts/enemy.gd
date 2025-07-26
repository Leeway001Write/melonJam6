extends CharacterBody2D

var dir = Vector2.ZERO
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("Player")
@export var speed:int = 100
@export var turn_speed:float = 12

func _physics_process(delta: float) -> void:
	
	# Calculate a direction vector 
	dir = Vector2(player.global_position - global_position).normalized()
	
	# Calculate velocity and rotate towards player
	velocity = dir * speed
	look_at(player.global_position)
	
	move_and_slide()
