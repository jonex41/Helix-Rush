extends Area3D

@export var duration: float = 1.0
@export var upward_speed: float = -1   # space drift speed

func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		var rb := body as RigidBody3D
		#disable collision
		body.disable_collision(true)

		# Save original values
		var original_gravity := rb.gravity_scale
		var original_damp := rb.linear_damp
		
		

		# Disable gravity
		rb.gravity_scale = 0.0

		# Reduce inertia (space feel)
		

		# Push upward
		rb.linear_velocity.y = upward_speed

		# Maintain upward drift
		var timer := get_tree().create_timer(duration)
		while timer.time_left > 0:
			if not is_instance_valid(rb):
				return
			rb.linear_velocity.y = upward_speed
			await get_tree().physics_frame

		# Restore physics
		if is_instance_valid(rb):
			rb.gravity_scale = original_gravity
			rb.linear_damp = original_damp
			body.disable_collision(false)
