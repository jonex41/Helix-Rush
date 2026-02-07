extends RigidBody3D

@onready var bounce_sound: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var min_impact_speed := 2.0
@export var cooldown := 0.05
@export var decal_scene: PackedScene
var bounce_count :int = 0

#getting count


var last_velocity_y := 0.0
var bounce_cooldown := false



# Tune this (VERY IMPORTANT)
@export var min_bounce_velocity := 0.05

func _physics_process(_delta):
	# Reset cooldown once body is clearly falling again
	if linear_velocity.y < -min_bounce_velocity:
		bounce_cooldown = false

	last_velocity_y = linear_velocity.y

func _integrate_forces(state):
	if bounce_cooldown:
		return

	for i in range(state.get_contact_count()):
		var normal = state.get_contact_local_normal(i)

		#var point = state.get_contact_local_position(i)
		
		# Must be a TOP surface
		print("integrate force ", normal.dot(Vector3.UP))
		if normal.dot(Vector3.UP) < 0.6:
			continue

		# Detect velocity direction flip (DOWN → UP)
		var vy := linear_velocity.y

		if  vy > min_bounce_velocity:
			GameTimer.increase_ball_bounce()
			if  GameTimer.can_play_sound:
				$AudioStreamPlayer3D.play()
			#_spawn_decal(state, point, normal)
			bounce_cooldown = true
			
			break





func free_palayer():
	self.queue_free()
				
func disable_collision(disable):
	if disable:
		$CollisionShape3D.set_deferred("disabled", true)
	else :
		$CollisionShape3D.set_deferred("disabled", false)
		
func show_jetpack(is_show: bool) :
	$JetPack.visible = is_show	
	if is_show:
		$JetPack.start_thrust()
	else  :
		$JetPack.stop_thrust()


func _spawn_decal(state, local_point: Vector3, normal: Vector3):
	var decal := decal_scene.instantiate()
	get_tree().current_scene.add_child(decal)

	# Convert to world space
	var global_pos = state.transform * local_point
	decal.global_position = global_pos

	# Rotate decal to face surface normal
	decal.look_at(global_pos + normal, Vector3.UP)
	decal.rotate_object_local(Vector3.RIGHT, PI)

	# Optional: random rotation for variation
	decal.rotate_object_local(Vector3.FORWARD, randf_range(0, TAU))




func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	var state = PhysicsServer3D.body_get_direct_state(get_rid())
	
	# Check all current contacts
	for i in range(state.get_contact_count()):
		var normal = state.get_contact_local_normal(i)
		
		# A normal pointing UP (Y > 0.7) means the surface is below the ball
		# 1.0 is a perfectly flat floor; 0.7 allows for slight slopes
		#print("my normal ",normal.y)
		if normal.y > 0.5:
			bounce_count += 1
			#print("Bounce counted! Total: ", bounce_count)
			break # Count only one bounce per impact frame
	pass # Replace with function body.
