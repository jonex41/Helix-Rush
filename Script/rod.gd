extends StaticBody3D
#a0a13800
@export var sensitivity := 0.005
@export var target: NodePath
@export var base_area: NodePath

@onready var other := get_node(target)
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D




var yaw := 0.0
var dragging := false

var last_touch_x := 0.0
var dull_colors = [
	#Color(0.4, 0.4, 0.4),   # gray
	#Color(0.5, 0.45, 0.4),  # dull brown
	Color(0.4, 0.5, 0.45),  # muted green
	#Color(0.45, 0.45, 0.5), # dull blue-gray
	#Color(0.5, 0.4, 0.45),  # dusty pink
	#Color(0.35, 0.4, 0.3),  # olive
	#Color(0.3, 0.35, 0.4),  # slate
	#Color(0.5, 0.5, 0.45),  # warm gray
	#Color(0.4, 0.35, 0.35), # faded red
	#Color(0.45, 0.5, 0.4),   # soft green
	Color("a0a13800"),      # your custom color (with alpha)
	Color.WHITE        
]

func get_random_dull_color() -> Color:
	return dull_colors[randi() % dull_colors.size()]

func _ready():
	EventBus.pause_game.connect(disable_input)
	randomize()
	
	var color = get_random_dull_color()
	
	var mat = mesh_instance_3d.get_active_material(0)

	if mat:
		mat.albedo_color = get_random_dull_color()
	pass



func _unhandled_input(event):
	#print('i am here')
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
