extends StaticBody3D

@export var spin_speed := 180.0        # degrees per second
@export var float_height := 0.06       # how high it moves up/down
@export var float_speed := 2.0         # speed of floating

var start_y := 0.0
var time := 0.0
var coinvfx_scene: PackedScene = preload("res://Scene/coinvfx.tscn")


func _ready():
	start_y = global_position.y

func _process(delta):
	# Spin around Y axis
	rotation.y += deg_to_rad(spin_speed) * delta

	# Floating up and down
	time += delta
	var new_y = start_y + sin(time * float_speed) * float_height
	global_position.y = new_y


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		var rb := body as RigidBody3D
		ScoreManager.add(2)
		
		var coinvfx = coinvfx_scene.instantiate()
		
		add_child(coinvfx)
		if  GameTimer.can_play_sound:
			$AudioStreamPlayer3D.play()
		
		$coin.visible= false
		$Area3D.set_deferred("monitoring",false)
		$Area3D.set_deferred("monitorable", false)
		#await get_tree().create_timer(1).timeout
	
		
		
	pass # Replace with function body.

	
