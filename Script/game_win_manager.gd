extends Node2D

@export var scene_a: PackedScene
@export var scene_b: PackedScene

@onready var holder := $SceneHolder

var current_scene: Node = null
var showing_a := true

func _ready():
	GameTimer.set_is_playing(false) 
	swap_to(scene_a)

func swap():
	if showing_a:
		swap_to(scene_b)
	else:
		swap_to(scene_a)

	showing_a = !showing_a


func swap_to(scene: PackedScene):
	# Remove old scene
	if current_scene:
		current_scene.queue_free()

	# Add new scene
	current_scene = scene.instantiate()
	holder.add_child(current_scene)
