extends CharacterBody2D

@export var rot_range = Vector2(-1, 1) # Min and max rotation

@onready var rot_speed = randf_range(rot_range.x, rot_range.y)
@onready var asteroid_sprites = [$Asteroid1, $Asteroid2, $Asteroid3]

func _ready() -> void:
	var picked_asteroid:Sprite2D = asteroid_sprites.pick_random()
	picked_asteroid.visible = true

func _physics_process(delta: float) -> void:
	rotate(deg_to_rad(rot_speed))
	move_and_slide()
