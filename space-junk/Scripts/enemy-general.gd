extends CharacterBody2D

class_name Enemy

@export var health:int = 10
@export var max_player_dist = 1100
@export var points:int = 15

@onready var player:CharacterBody2D = get_tree().get_first_node_in_group('Player')
@onready var score_manager = get_tree().get_first_node_in_group('Score')
@onready var explosion_sound = preload("res://Prefabs/explode-sound.tscn")

var activated = false
var player_dist

func _on_area_entered(area:Area2D):
	if area.is_in_group('PlayerBullet'):
		_hurt()
		
func _hurt():
	health -= 1
	
	if health <= 0:
		_die()
		
func _die(): # Guess I'll die *shrug*
	var explode_sound_inst = explosion_sound.instantiate()
	explode_sound_inst.global_position = get_tree().get_first_node_in_group('Cam').global_position
	get_tree().root.add_child.call_deferred(explode_sound_inst)
	score_manager.increase_score(points)
	$Sprite2D.play()
	$Area2D.queue_free()
	await get_tree().create_timer(.5).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	player_dist = sqrt((global_position.x - player.global_position.x) ** 2 + (global_position.y - player.global_position.y) ** 2)
	activated = player_dist < max_player_dist
	
