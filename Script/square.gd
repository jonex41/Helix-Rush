extends RigidBody3D

@export var rotation_strength := Vector3(6.0, 4.0, 3.0)
@export var max_step := 0.25   # prevents insane spin

@onready var visual := $MeshInstance3D
var last_pos: Vector3

func _ready():
	last_pos = global_position

func _process(delta):
	var delta_pos = global_position - last_pos

	# Clamp movement to avoid extreme spin
	delta_pos.x = clamp(delta_pos.x, -max_step, max_step)
	delta_pos.y = clamp(delta_pos.y, -max_step, max_step)
	delta_pos.z = clamp(delta_pos.z, -max_step, max_step)

	# Map movement to rotation (Helix Jump style)
	visual.rotate_x(-delta_pos.y * rotation_strength.x)
	visual.rotate_y(delta_pos.x * rotation_strength.y)
	visual.rotate_z(delta_pos.z * rotation_strength.z)

	last_pos = global_position

#@export var bounce_strength := 8.0
#
#func _integrate_forces(state):
	#for i in state.get_contact_count():
		#var normal = state.get_contact_local_normal(i)
#
		## Only bounce off upward surfaces
		#if normal.dot(Vector3.UP) > 0.7:
			#var vel = linear_velocity
			#if vel.y < 0:
				#vel.y = bounce_strength
				#linear_velocity = vel
func free_palayer():
	self.queue_free()
				
func disable_collision(disable):
	if disable:
		$CollisionShape3D.set_deferred("disabled", true)
	else :
		$CollisionShape3D.set_deferred("disabled", false)
		
func show_jetpack(is_show: bool) :
	$JetPack.visible = is_show	
	
