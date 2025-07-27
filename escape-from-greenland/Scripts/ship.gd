extends CharacterBody2D

@export var turn_speed:float = 12
@export var health = 50

#var speed:float = 0
var song_comp_total = 0
var move_vector = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move_vector = Vector2.ZERO # Reinitialize it
	for booster:Booster in $Components/Boosters.get_children():
		move_vector += booster.dir_vector * booster.speed
	if Input.is_action_pressed('forward'):
		velocity += move_vector
	velocity /= 1.01
	
	$Arrow.global_rotation = atan2(move_vector.y, move_vector.x)
	
	#var dir = Vector2($ForwardPos.global_position - global_position).normalized()
	
	var turn_axis = Input.get_axis('left', 'right')
	rotate(deg_to_rad(turn_speed * turn_axis) * Engine.time_scale)
	move_and_slide()

func _process(delta: float) -> void:
	song_comp_total = len($Components/Boosters.get_children()) + len($Components/Guns.get_children())
	
	var audios = $Camera2D/Audios.get_children()
	for i in range(len(audios)):
		var audio:AudioStreamPlayer2D = audios[i]
		if i + 1 > song_comp_total:
			var tween = get_tree().create_tween()
			tween.tween_property(audio, 'volume_db', -80, .2)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(audio, 'volume_db', 0, .1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('Component'):
		_attach_item(area.get_parent(), area)
		
	if area.is_in_group('DamagePlayer'):
		if health > 0 and health < 50:
			$AudioStreamPlayer2D.play(0)
			health -= 3
			print(health)
			if health <= 0:
				print("game over")
				$AudioStreamPlayer2D.set_pitch_scale(0.5)
				$AudioStreamPlayer2D.play(0)
				get_tree().change_scene_to_file.call_deferred('res://Menus/gameOver.tscn')
	
	if area.is_in_group('Consumable'):
		
		health += 10
		if health > 50:
			health = 50
		area.get_parent().queue_free()

func _attach_item(component: Component, area: Area2D):
	if component.attached:
		return
	
	if not component.hit_something.is_connected(_attach_item):
		component.hit_something.connect(_attach_item)
	component.invincibility()
	if area.is_in_group('Booster'):
		component.reparent.call_deferred($Components/Boosters)
	elif area.is_in_group('Gun'):
		component.reparent.call_deferred($Components/Guns)
	elif area.is_in_group('Junk'):
		component.reparent.call_deferred($Components/Junk)
	await get_tree().process_frame
	component.attached = true
