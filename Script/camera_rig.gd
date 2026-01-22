extends Node3D

@export var follow_speed_y := 3.0
@export var dead_zone := 0.6 # Ignore small bounces
var target: Node3D = null



func set_target(scene_instance: Node3D):
	print('set target')
	print(scene_instance)
	print('set target')
	target = scene_instance
	

func _ready():
	#original_position = position
	pass




func _process(delta):
	
	if not target:
		
		return
	var current_y := global_position.y
	var target_y := target.global_position.y

	# Ignore small vertical movements
	if abs(target_y - current_y) < dead_zone:
		return

	global_position.y = lerp(
		current_y,
		target_y,
		follow_speed_y * delta
	)
