extends CharacterBody2D

class_name Component

@export var attached:bool
@onready var trigger:Area2D = $Area2D

var attached_items=[]
signal hit_something

#func _ready() -> void:
	#if attached:
		#trigger.get_child(0).disabled = true
#
#func _process(delta: float) -> void:
	#
	#if attached:
		#trigger.get_child(0).disabled = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not attached:
		return
	print_debug(area.get_parent().name)
	if area.is_in_group("Component"):
		var component = area.get_parent()
		hit_something.emit(component, area)
		attached_items.append(component)
