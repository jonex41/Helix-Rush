extends CPUParticles2D

@export var color_mod_array : Array[Color]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate= rand_color()
	emitting = true
	finished.connect(queue_free)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func rand_color()-> Color:
	var array_size = color_mod_array.size()
	var rand_index = randi() % array_size
	var r_color = Color(color_mod_array[rand_index])
	return r_color
