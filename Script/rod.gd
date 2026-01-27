extends StaticBody3D

@export var sensitivity := 0.005
@export var target: NodePath
@export var base_area: NodePath

@onready var other := get_node(target)




var yaw := 0.0
var dragging := false

var last_touch_x := 0.0



func _ready():
	EventBus.pause_game.connect(disable_input)



func _unhandled_input(event):
	if GameTimer.disable_rotation_input:
		return
		
	if !GameTimer.is_playing:
		
		GameTimer.set_is_playing(true) 
		GameTimer.reset()
		GameTimer.can_count_num_bounce(true)
		
	
	# ---------- TOUCH (Android / iOS) ----------
	if event is InputEventScreenTouch:
		dragging = event.pressed
		last_touch_x = event.position.x

	elif event is InputEventScreenDrag and dragging:
		var delta_x = event.position.x - last_touch_x
		yaw += delta_x * sensitivity
		rotation.y = yaw
		other.rotation.y = yaw
		#other2.rotation.y = yaw
		last_touch_x = event.position.x

	# ---------- MOUSE (Desktop) ----------
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed

	elif event is InputEventMouseMotion and dragging:
		yaw += event.relative.x * sensitivity
		rotation.y = yaw
		other.rotation.y = yaw
		#other2.rotation.y = yaw
# ---------- Disable Input ----------
func disable_input(pause: bool):
	GameTimer.disable_rotation_input = pause
	pass
