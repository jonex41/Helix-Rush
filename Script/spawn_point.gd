extends Node3D

var spawn_scene: PackedScene
@export var spawn_point: NodePath

@onready var point: Marker3D = get_node(spawn_point)

func set_scene(scene_path: String):
	spawn_scene = load(scene_path)

func spawn():
	if not spawn_scene or not point:
		
		push_error("Spawn scene or spawn point missing")
		return

	var instance:= spawn_scene.instantiate()
	add_child(instance)
	#$"../CameraRig".set_target(instance
	get_tree().call_group("CameraRig", "set_target", instance)

	
	instance.global_transform = point.global_transform


func _on_ready() -> void:
	set_scene(GameTimer.selectedBallScene)
	spawn()
	
	pass # Replace with function body.
