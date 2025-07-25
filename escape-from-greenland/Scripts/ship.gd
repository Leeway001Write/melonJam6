extends CharacterBody2D

var speed:float = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('forward'):
		for booster:Booster in $Components/Boosters.get_children():
			speed += booster.speed
		#print_debug(speed)
	
	var dir = Vector2($ForwardPos.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()
