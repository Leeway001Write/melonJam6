extends Component

class_name Gun

@export var speed = 500
@onready var bullet = preload("res://Prefabs/bullet.tscn")
@onready var ship:CharacterBody2D = get_tree().get_first_node_in_group('Player')
var dir = Vector2.ZERO


func _physics_process(delta: float) -> void:
	# Get the direction the bullet fires
	dir = Vector2($ForwardPos.global_position - global_position).normalized()


func _on_timer_timeout() -> void:
	if not Input.is_action_pressed('fire') or not attached: return
	var bullet_inst:CharacterBody2D = bullet.instantiate()
	bullet_inst.velocity = dir * speed + ship.velocity
	bullet_inst.global_position = $ForwardPos.global_position
	get_tree().root.add_child.call_deferred(bullet_inst)
