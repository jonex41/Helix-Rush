extends Node3D

@export var base_speed := Vector3(2.5, 1.2, 0.8)
@export var speed_variation := Vector3(1.5, 0.8, 0.6)
@export var wobble_strength := 0.4
@export var change_interval := 1.8

var current_speed := Vector3.ZERO
var target_speed := Vector3.ZERO
var time := 0.0

func _ready():
	randomize()
	_pick_new_speeds()

func _process(delta):
	time += delta

	# Smoothly interpolate toward target speeds
	current_speed = current_speed.lerp(target_speed, delta * 2.0)

	# Core rotation (different speeds per axis)
	rotate_x(current_speed.x * delta)
	rotate_y(current_speed.y * delta)
	rotate_z(current_speed.z * delta)

	# Organic wobble (adds life)
	rotate_x(sin(time * 1.2) * wobble_strength * delta)
	rotate_y(cos(time * 1.5) * wobble_strength * delta)
	rotate_z(sin(time * 1.1) * wobble_strength * delta)

func _pick_new_speeds():
	target_speed = Vector3(
		randf_range(base_speed.x - speed_variation.x, base_speed.x + speed_variation.x),
		randf_range(base_speed.y - speed_variation.y, base_speed.y + speed_variation.y),
		randf_range(base_speed.z - speed_variation.z, base_speed.z + speed_variation.z)
	)

	await get_tree().create_timer(change_interval).timeout
	_pick_new_speeds()
