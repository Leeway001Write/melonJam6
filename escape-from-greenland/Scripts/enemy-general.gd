extends CharacterBody2D

class_name Enemy

@export var health:int

func _on_area_entered(area:Area2D):
	if area.is_in_group('PlayerBullet'):
		_hurt()
		
func _hurt():
	health -= 1
	if health <= 0:
		queue_free()
