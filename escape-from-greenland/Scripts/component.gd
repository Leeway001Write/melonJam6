extends Node

class_name Component

@export var attached:bool
@onready var trigger:Area2D = $Area2D

func _process(delta: float) -> void:
	
	if attached:
		trigger.monitorable = false
