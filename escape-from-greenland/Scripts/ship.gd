extends CharacterBody2D

@export var turn_speed:float = 12

#var speed:float = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('forward'):
		for booster:Booster in $Components/Boosters.get_children():
			var child_vector = -Vector2(booster.global_position - global_position).normalized()
			child_vector *= booster.speed
			velocity += child_vector
	
	#var dir = Vector2($ForwardPos.global_position - global_position).normalized()
	
	var turn_axis = Input.get_axis('left', 'right')
	rotate(deg_to_rad(turn_speed * turn_axis))
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Component'):
		if body.attached:
			print_debug("It's attached")
			return
		if body.is_in_group('Booster'):
			$Components/Boosters.add_child.call_deferred(body)
