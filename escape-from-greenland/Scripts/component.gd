extends CharacterBody2D

class_name Component

@export var attached:bool
@export var health:int
@export var test:bool
@onready var trigger:Area2D = $Area2D

signal hit_something
signal destroyed

#func _ready() -> void:
	#if attached:
		#trigger.get_child(0).disabled = true
#
#func _process(delta: float) -> void:
	#
	#if attached:
		#trigger.get_child(0).disabled = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Component"):
		var component:Component = area.get_parent()
		if component.attached:
			if not component.destroyed.is_connected(destroy):
				print_debug("I'm Attaching now")
				component.destroyed.connect(destroy)
		if not attached:
			return
		hit_something.emit(component, area)
	elif area.is_in_group("DamagePlayer"):
		_hurt()

func _hurt():
	health -= 1
	if health <= 0:
		destroy()
	

func destroy():
	destroyed.emit()
	queue_free()
