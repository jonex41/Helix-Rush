extends RigidBody3D

@export var mouse_sensitivity: float = 0.1
var mouse_input: Vector2 = Vector2.ZERO

func _ready():
	# Recommended: Capture the mouse so it doesn't leave the window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		# Accumulate mouse movement
		mouse_input += event.relative

func _integrate_forces(state: PhysicsDirectBodyState3D):
	if mouse_input != Vector2.ZERO:
		# Convert mouse X movement to rotation around local Y axis
		# Convert mouse Y movement to rotation around local X axis
		var torque = Vector3.ZERO
		torque -= state.transform.basis.y * mouse_input.x * mouse_sensitivity
		torque -= state.transform.basis.x * mouse_input.y * mouse_sensitivity
		
		# Apply as an impulse for immediate response
		apply_torque_impulse(torque)
		
		# Reset input so it doesn't spin forever
		mouse_input = Vector2.ZERO
