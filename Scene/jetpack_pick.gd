extends StaticBody3D


@export var spin_speed := 180.0        # degrees per second
@export var float_height := 0.06       # how high it moves up/down
@export var float_speed := 2.0         # speed of floating

var start_y := 0.0
var time := 0.0

func _ready():
	start_y = global_position.y

func _process(delta):
	# Spin around Y axis
	rotation.y += deg_to_rad(spin_speed) * delta

	# Floating up and down
	time += delta
	var new_y = start_y + sin(time * float_speed) * float_height
	global_position.y = new_y





func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		#var rb := body as RigidBody3D
		GameTimer.add_power_antigravity()
		
		print('i am here')
		queue_free()
	pass # Rplace with function body.
