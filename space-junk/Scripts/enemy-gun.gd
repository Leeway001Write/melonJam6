extends Node2D

@export var speed = 500
@onready var bullet = preload("res://Prefabs/bullet.tscn")
var dir = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Get the direction the bullet fires
	dir = Vector2($ForwardPos.global_position - global_position).normalized()

func _on_timer_timeout() -> void:
	var bullet_inst:CharacterBody2D = bullet.instantiate()
	bullet_inst.velocity = dir * speed
	bullet_inst.global_position = global_position
	get_tree().root.add_child.call_deferred(bullet_inst)
