extends CharacterBody2D

@export var turn_speed:float = 12

#var speed:float = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('forward'):
		for booster:Booster in $Components/Boosters.get_children():
			velocity += booster.dir_vector
	
	#var dir = Vector2($ForwardPos.global_position - global_position).normalized()
	
	var turn_axis = Input.get_axis('left', 'right')
	rotate(deg_to_rad(turn_speed * turn_axis))
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('Component'):
		var component:Component = area.get_parent()
		if component.attached:
			return
		if area.is_in_group('Booster'):
			component.reparent.call_deferred($Components/Boosters)
			component.attached = true
