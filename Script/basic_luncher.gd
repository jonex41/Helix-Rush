extends Area3D
@export var launch_speed := 5.0
#deform
@onready var mesh := $trampoline

@export var compress_y := 0.6
@export var expand_xz := 1.1
@export var duration := 0.12

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



	

func _on_body_entered(body):
	if body is RigidBody3D:
		body.linear_velocity.y = launch_speed
	

	pass # Replace with function body.


func deform():
	if tween:
		tween.kill()

	tween = create_tween()

	# compress
	tween.tween_property(
		mesh,
		"scale",
		Vector3(expand_xz, compress_y, expand_xz),
		duration
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	# release
	tween.tween_property(
		mesh,
		"scale",
		Vector3.ONE,
		duration
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
