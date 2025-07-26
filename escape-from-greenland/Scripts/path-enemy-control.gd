extends Path2D

@export var speed:float
@export var max_dist:float
@export var bullet_speed:float

@onready var path_follow = $PathFollow2D
@onready var enemy_ship = $Enemy
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group('Player')
@onready var bullet = preload("res://Prefabs/bullet.tscn")

var firing = true

func _physics_process(delta: float) -> void:
	path_follow.progress += speed
	enemy_ship.global_position = path_follow.global_position
	# Basically just the distance formula to see how far the player is
	var enemy_dist = sqrt(((enemy_ship.global_position.x - player.global_position.x) ** 2.0) + ((enemy_ship.global_position.y - player.global_position.y) ** 2.0))
	firing = enemy_dist < max_dist
	



func _on_timer_timeout() -> void:
	if firing:
		var bullet_inst = bullet.instantiate()
		bullet_inst.global_position = enemy_ship.global_position
		
		# Calculate the direction of the bullets
		var bullet_vector = Vector2(player.global_position - enemy_ship.global_position).normalized()
		# Remove the bullet from the wrong class and put it in the right class
		bullet_inst.find_child('Area2D').remove_from_group('PlayerBullet')
		bullet_inst.find_child('Area2D').add_to_group('DamagePlayer')
		bullet_inst.velocity = bullet_vector * bullet_speed
		get_tree().root.add_child.call_deferred(bullet_inst)
