extends StaticBody3D
@onready var mesh: MeshInstance3D = find_child("Cylinder", true, false)
var mat : StandardMaterial3D
var bounce_count : int = 0

func _ready():
	bounce_count = 0
	if mesh != null:
		var base_mat = mesh.get_active_material(0)
		mat = base_mat.duplicate()
		mesh.set_surface_override_material(0, mat)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_area_3d_body_entered(body: Node3D) -> void:
		if body is RigidBody3D && mesh != null:
			body.play_audio()
			var base_mat = mesh.get_active_material(0)

			if base_mat == null:
				push_error("No material found on mesh!")
				return

			mat = base_mat.duplicate() as StandardMaterial3D
			mesh.set_surface_override_material(0, mat)
			if bounce_count== 1:
				ScoreManager.green-=5
				ScoreManager.green_yellow+=2
				mat.albedo_color = Color.GREEN_YELLOW
			elif bounce_count== 2:
				ScoreManager.green_yellow-=2
				ScoreManager.red+=1
				mat.albedo_color = Color.RED
			bounce_count+= 1
			
		pass # Replace with function body.


func _on_area_3d_platform_body_entered(body: Node3D) -> void:
	if body is RigidBody3D && mesh != null:
		body.play_audio()
		var base_mat = mesh.get_active_material(0)

		if base_mat == null:
			push_error("No material found on mesh!")
			return

		mat = base_mat.duplicate() as StandardMaterial3D
		mesh.set_surface_override_material(0, mat)
		$Area3DPlatform.queue_free()
		$Area3D.visible=true
		mat.albedo_color = Color.GREEN
		ScoreManager.green+=5
		bounce_count = 1
		print('change color here')
	pass # Replace with function body.
