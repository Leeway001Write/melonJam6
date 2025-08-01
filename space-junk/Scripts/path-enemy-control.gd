extends Path2D

@export var speed:float
@export var max_dist:float
@export var bullet_speed:float

@onready var path_follow = $PathFollow2D
@onready var enemy_ship = $Enemy
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group('Player')
@onready var bullet = preload("res://Prefabs/bullet-enemy.tscn")

var firing = true
var enemy_dead = false
var fire_from_left = true

func _ready() -> void:
	enemy_ship.died.connect(_enemy_die)
	
func _enemy_die():
	enemy_dead = true

func _physics_process(delta: float) -> void:
	if enemy_dead: return
	# Check if the enemy still exists. If not, destory itself
	if not is_instance_valid(enemy_ship): queue_free()
	path_follow.progress += speed
	enemy_ship.global_position = path_follow.global_position
	# Basically just the distance formula to see how far the player is
	var enemy_dist = sqrt(((enemy_ship.global_position.x - player.global_position.x) ** 2.0) + ((enemy_ship.global_position.y - player.global_position.y) ** 2.0))
	firing = enemy_dist < max_dist
	
	enemy_ship.look_at(player.global_position)

func _on_timer_timeout() -> void:
	if enemy_dead: return
	if firing:
		var bullet_inst = bullet.instantiate()
		
		# Determine which arm to fire bullet from
		if fire_from_left:
			bullet_inst.global_position = $Enemy/LeftArm.global_position
			fire_from_left = false
		else:
			bullet_inst.global_position = $Enemy/RightArm.global_position
			fire_from_left = true
		
		# Calculate the direction of the bullets
		var bullet_vector = Vector2(player.global_position - enemy_ship.global_position).normalized()
		
		# Remove the bullet from the wrong class and put it in the right class
		bullet_inst.find_child('Area2D').remove_from_group('PlayerBullet')
		bullet_inst.find_child('Area2D').add_to_group('DamagePlayer')
		bullet_inst.velocity = bullet_vector * bullet_speed
		bullet_inst.global_rotation = atan2(bullet_vector.y, bullet_vector.x)
		get_tree().root.add_child.call_deferred(bullet_inst)
