extends CharacterBody2D

class_name Component

@export var attached:bool
@export var health:int
@export var test:bool
@export var rot_range = Vector2(-1, 1) # Min and max rotation
@onready var trigger:Area2D = $Area2D
@onready var rot_speed = randf_range(rot_range.x, rot_range.y)

var invincible = false

signal hit_something
signal destroyed

func _ready() -> void:
	if attached:
		trigger.get_child(0).disabled = true
#
#func _process(delta: float) -> void:
	#
	#if attached:
		#trigger.get_child(0).disabled = true
		
func _physics_process(delta: float) -> void:
	if not attached:
		rotate(deg_to_rad(rot_speed))
		move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Component"):
		var component:Component = area.get_parent()
		if component.attached:
			if not component.destroyed.is_connected(destroy):
				component.destroyed.connect(destroy)
		if not attached:
			return
		hit_something.emit(component, area)
		invincible = true
		invincible = false
	elif area.is_in_group("DamagePlayer") and attached:
		_hurt()
	elif area.is_in_group('Asteroid'):
		_hurt()
		_hurt()
		_hurt()
		_hurt()

func _hurt():
	if invincible: return
	health -= 1
	get_tree().get_first_node_in_group('Cam').shake()
	if health <= 0:
		#Engine.time_scale = .01
		#await get_tree().create_timer(.013).timeout
		#Engine.time_scale = 1
		destroy()

func invincibility():
	invincible = true
	await get_tree().create_timer(1.1).timeout
	invincible = false

func destroy():
	destroyed.emit()
	queue_free()
