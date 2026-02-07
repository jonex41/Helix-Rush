extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one_shot = true
	emitting = true
	finished.connect(_on_finished)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


	
	
func _on_finished():
	get_parent().queue_free()
