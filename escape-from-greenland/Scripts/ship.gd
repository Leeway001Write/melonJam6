extends CharacterBody2D

@export var turn_speed:float = 12

#var speed:float = 0
var song_comp_total = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('forward'):
		for booster:Booster in $Components/Boosters.get_children():
			velocity += booster.dir_vector
	
	velocity /= 1.01
	
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

func _attach_item(component: Component, area: Area2D):
	if component.attached:
		return
	
	if not component.hit_something.is_connected(_attach_item):
		component.hit_something.connect(_attach_item)
	component.invincibility()
	if area.is_in_group('Booster'):
		component.reparent.call_deferred($Components/Boosters)
	if area.is_in_group('Gun'):
		component.reparent.call_deferred($Components/Guns)
	await get_tree().process_frame
	component.attached = true
