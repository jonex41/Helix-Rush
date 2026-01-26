extends Node3D

@export var pull_speed := 2.5

@onready var area := $"../../../AreaMeatBody"
@onready var path := $"../.."
@onready var follow := $".."

var target: RigidBody3D
var moving := false
var t := 0.0

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is RigidBody3D and not moving:
		target = body
		_create_curve()
		moving = true
func _create_curve():
	var curve := Curve3D.new()

	var start := global_position
	var end := target.global_position

	# control point to create the curve
	var mid := start.lerp(end, 0.5)
	mid.y += 1.5 # curve height (tweak for style)

	curve.add_point(start)
	curve.add_point(mid)
	curve.add_point(end)

	path.curve = curve
	follow.progress_ratio = 0.0
	t = 0.0
func _process(delta):
	if not moving:
		return

	t += delta * pull_speed
	t = min(t, 1.0)

	follow.progress_ratio = t

	# keep end locked to player
	if target:
		path.curve.set_point_position(2, target.global_position)

	# scale down as it reaches the target
	var scale_factor = lerp(1.0, 0.0, t)
	follow.scale = Vector3.ONE * scale_factor

	if t >= 1.0:
		queue_free()



func _on_area_meat_body_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
