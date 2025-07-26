extends Enemy

@export var speed: float = 700
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group('Player')
var charging = false

func _ready() -> void:
	_charge()
	
func _physics_process(delta: float) -> void:
	if charging:
		velocity = Vector2.RIGHT.rotated(rotation) * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _charge():
	var dist = sqrt((player.global_position.x - global_position.x) * (player.global_position.x - global_position.x) + (player.global_position.y - global_position.y) * (player.global_position.y - global_position.y))
	print_debug(dist)
	var diff = player.global_position - global_position
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'rotation', atan2(diff.y, diff.x), .6)
	await get_tree().create_timer(.6).timeout
	charging = true
	$Timer.start()
	


func _on_timer_timeout() -> void:
	charging = false
	_charge()
