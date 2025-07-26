extends CharacterBody2D

var dir = Vector2.ZERO
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("Player")
@export var speed:int = 100
@export var turn_speed:float = 12

@onready var bullet = preload("res://Prefabs/bullet.tscn")


func _physics_process(delta: float) -> void:
	
	# Calculate a direction vector 
	dir = Vector2(player.global_position - global_position).normalized()
	
	# Calculate velocity and rotate towards player
	velocity = dir * speed
	look_at(player.global_position)
	
	move_and_slide()

#
#func _on_timer_timeout() -> void:
	#var bullet_inst:CharacterBody2D = bullet.instantiate()
	#bullet_inst.velocity = dir * speed
	#bullet_inst.global_position = $Gun2/ForwardPos.global_position
	#get_tree().root.add_child.call_deferred(bullet_inst)
