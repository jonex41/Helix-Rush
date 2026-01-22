extends Area3D

var duration: float = 0
@export var upward_speed: float = 1   # space drift speed
signal show_progress(isCollision)

func _ready() -> void:
	duration = GameTimer.initial_power_antigravity_timer
	await get_tree().process_frame
	await get_tree().process_frame  # extra safety
	var ui = get_tree().get_first_node_in_group("ProgressBarControl")
	if ui:
		show_progress.connect(ui.update_progress)
	else:
		print("UI not found")
	pass # Replace with function body.

func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D && !GameTimer.power_is_active:
		var rb := body as RigidBody3D
		show_progress.emit(false)
		GameTimer.set_is_power_active(true)
		# Save original values
		var original_gravity := rb.gravity_scale
		var original_damp := rb.linear_damp

		# Disable gravity
		rb.gravity_scale = 0.0

		# Reduce inertia (space feel)
		rb.linear_damp = 0.5

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
			print('return to original')
			rb.gravity_scale = original_gravity
			rb.linear_damp = original_damp
			GameTimer.set_is_power_active(false)
