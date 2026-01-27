extends Node

var flat_material := StandardMaterial3D.new()

func _ready():
	flat_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	flat_material.albedo_color = Color(18.892, 5.603, 5.245, 1.0)
