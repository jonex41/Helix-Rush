extends Control


@export var duration: float = 0
@export var upward_speed: float = 1   # space drift speed

@export var duration_collision: float = 0
@export var upward_speed_collision: float = 1   # space drift speed
@export var xp_bar: ColorRect

#time stuff
@export var total_time := 0   # seconds
@export var step_percent := 5  # decrease by 5%

var remaining_time := 0.0
var step_time := 0.0
var current_value := 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("ProgressBarControl")
	duration =	GameTimer.initial_power_antigravity_timer 
	duration_collision = GameTimer.initial_power_collision_timer
	



	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$VBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/PowerText2.text = str(GameTimer.initial_power_collision)
	$VBoxContainer/MarginContainer2/VBoxContainer/PowerText1.text= str(GameTimer.initial_power_antigravity)

	
	# time stuff
	if remaining_time <= 0:
		show_progress_bar(false)
		xp_bar.set_bar_value(100)
		return

	remaining_time -= delta

	# Reduce progress bar in steps
	if remaining_time <= total_time - ((100 - current_value) / step_percent) * step_time:
		current_value -= step_percent
		current_value = max(current_value, 0)
		print(current_value)
		xp_bar.set_bar_value(current_value)
	pass
		
			


func _remove_gravity() -> void:
	
	if GameTimer.initial_power_antigravity < 1  :
		return
	if GameTimer.power_is_active == true:
		return
	current_value = 100.0
	show_progress_bar(true)
	GameTimer.reduce_power_antigravity()
	GameTimer.set_is_power_active(true)
	total_time= duration
	step_time = total_time / (100.0 / step_percent)
	remaining_time = total_time
	var balls := get_tree().get_nodes_in_group("Player")

	if balls.size() > 0:
		var rb: RigidBody3D = balls[0]

		rb.show_jetpack(true)
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
			rb.show_jetpack(false)



func _removeCollision() -> void:
	if GameTimer.initial_power_collision < 1  :
		return
	if GameTimer.power_is_active == true:
		return
	
	show_progress_bar(true)
	GameTimer.reduce_power_collision()
	GameTimer.set_is_power_active(true)
	total_time= duration_collision
	step_time = total_time / (100.0 / step_percent)
	remaining_time = total_time
	var balls := get_tree().get_nodes_in_group("Player")

	if balls.size() > 0:
		var rb: RigidBody3D = balls[0]
		#disable collision
		rb.disable_collision(true)
		rb.show_jetpack(true)
		# Save original values
		var original_gravity := rb.gravity_scale
		var original_damp := rb.linear_damp
		
		

		# Disable gravity
		rb.gravity_scale = 0.0

		# Reduce inertia (space feel)
		rb.linear_damp = 0.5

		# Push upward
		rb.linear_velocity.y = upward_speed_collision

		# Maintain upward drift
		var timer := get_tree().create_timer(duration_collision)
		while timer.time_left > 0:
			if not is_instance_valid(rb):
				return
			rb.linear_velocity.y = upward_speed_collision
			await get_tree().physics_frame

		# Restore physics
		if is_instance_valid(rb):
			rb.gravity_scale = original_gravity
			rb.linear_damp = original_damp
			rb.disable_collision(false)
			GameTimer.set_is_power_active(false)
			rb.show_jetpack(false)


func _on_power_1_pressed() -> void:
	
	_remove_gravity()
	pass # Replace with function body.


func _on_power_text_1_pressed() -> void:
	
	_remove_gravity()
	pass # Replace with function body.


func _on_power_2_pressed() -> void:
	_removeCollision()
	pass # Replace with function body.


func _on_power_text_2_pressed() -> void:
	_removeCollision()
	pass # Replace with function body.
func show_progress_bar(is_visible:bool)->void:
	$VBoxContainer/HBoxContainer/HBoxContainer.visible = is_visible
	
func update_progress(isCollision)->void :
	show_progress_bar(true)
	if isCollision:
		total_time= duration_collision
		step_time = total_time / (100.0 / step_percent)
		remaining_time = total_time
	else :
		total_time= duration
		step_time = total_time / (100.0 / step_percent)
		remaining_time = total_time
		
