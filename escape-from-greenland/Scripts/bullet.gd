extends CharacterBody2D

func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if $Area2D.is_in_group("DamagePlayer"):
		if area.is_in_group('Component') or area.is_in_group('Player'):
			await get_tree().physics_frame
			queue_free()
	elif $Area2D.is_in_group('PlayerBullet'):
		if area.is_in_group('DamagePlayer'):
			await get_tree().physics_frame
			queue_free()
