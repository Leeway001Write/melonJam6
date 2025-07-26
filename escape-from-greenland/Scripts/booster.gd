extends Component

class_name Booster

@export var speed:float
var dir_vector = Vector2.ZERO

func _physics_process(delta: float) -> void:
	dir_vector = Vector2($ForwardPos.global_position - global_position).normalized() * speed
	if test && Input.is_action_just_pressed("DestroyTest"):
		_hurt()
