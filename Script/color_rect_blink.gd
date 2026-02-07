extends ColorRect
@export var next_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/intensity", 1.0, 0.1)
	tween.tween_property(material, "shader_parameter/intensity", 0.0, 0.2)
	await get_tree().create_timer(1.0).timeout
	self.queue_free()
	var scene = preload("res://Scene/game_over.tscn")
	var instance = scene.instantiate()
	add_child(instance)

	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
