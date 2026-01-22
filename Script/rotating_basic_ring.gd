extends StaticBody3D

@export var rotation_speed: float = 1   # radians per second
@export var axis: Vector3 = Vector3.UP    # rotation axis (Y by default)

func _process(delta):
	rotate(axis.normalized(), rotation_speed * delta)
