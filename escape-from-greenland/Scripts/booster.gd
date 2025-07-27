extends Component

class_name Booster

@export var speed:float
var dir_vector = Vector2.ZERO

func _physics_process(delta: float) -> void:
	super(delta)
	dir_vector = Vector2($ForwardPos.global_position - global_position).normalized() * speed
		
	if Input.is_action_just_pressed('forward') and attached:
		$CPUParticles2D.emitting = true
		$Fire.play('burst')
		await get_tree().create_timer(.5).timeout
		if Input.is_action_pressed('forward'):
			$Fire.play('burn')

	
	if Input.is_action_just_released('forward') and attached:
		$CPUParticles2D.emitting = false
		$Fire.play('burst', -1, true)
