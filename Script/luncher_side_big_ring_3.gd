extends StaticBody3D
#@onready var mesh: MeshInstance3D = $Cylinder2/Cylinder
@onready var mesh: MeshInstance3D = find_child("Cylinder", true, false)
var mat: StandardMaterial3D
var original_color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mesh != null:
		var base_mat = mesh.get_active_material(0)

	# Duplicate so we don't affect all instances
		mat = base_mat.duplicate()
		mesh.set_surface_override_material(0, mat)

		original_color = mat.albedo_color
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_color():
	mesh.albedo_color = Color(1, 0.3, 0.3)
	
