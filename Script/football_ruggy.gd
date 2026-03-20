extends RigidBody3D

@onready var bounce_sound: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var min_impact_speed := 2.0
@export var cooldown := 0.05
@onready var decal_scene = preload("res://Scene/decal_compatibility_mode.tscn")

#getting count


var last_velocity_y := 0.0
var bounce_cooldown := false



# Tune this (VERY IMPORTANT)
@export var min_bounce_velocity := 0.05

func _ready() -> void:
	#show_jetpack(true)
	#await get_tree().process_frame
	#show_jetpack(false)
	pass

func _physics_process(delta):
	# Reset cooldown once body is clearly falling again
	if linear_velocity.y < -min_bounce_velocity:
		bounce_cooldown = false

	last_velocity_y = linear_velocity.y

func _integrate_forces(state):
	if bounce_cooldown:
		return

	for i in range(state.get_contact_count()):
		
	  
		var normal = state.get_contact_local_normal(i)
		if normal and normal is StaticBody3D:
			var hit_position = state.get_contact_collider_position(i)
			var hit_normal = state.get_contact_collider_normal(i)
			spawn_decal(hit_position, hit_normal, normal)

		# Must be a TOP surface
		if normal.dot(Vector3.UP) < 0.6:
			continue

		# Detect velocity direction flip (DOWN → UP)
		var vy := linear_velocity.y

		if  vy > min_bounce_velocity:
			GameTimer.increase_ball_bounce()
			bounce_cooldown = true
			
			break
			
func spawn_decal(global_position: Vector3, normal: Vector3, target: Node3D):
	var decal = decal_scene.instantiate()
	decal.global_position = global_position
	#decal.look_at(global_position + normal, Vector3.UP)
	
	# Push slightly outward to prevent z-fighting
	#decal.global_position += normal * 0.02
	
	# Attach to static body
	target.add_child(decal)

func play_audio():
	if GameTimer.can_play_sound && GameTimer.is_playing :
		#print("palying : ",GameTimer.is_playing )
		$AudioStreamPlayer3D.play()
	else :
		$AudioStreamPlayer3D.stop()


func free_palayer():
	self.queue_free()
				
func disable_collision(disable):
	if disable:
		$CollisionShape3D.set_deferred("disabled", true)
	else :
		$CollisionShape3D.set_deferred("disabled", false)
		
func show_jetpack(is_show: bool) :
	$JetPack.visible = is_show	
		
	


func _on_body_entered(body: Node) -> void:
	if body is StaticBody3D:
		#print('i am here nw color')
		body.change_color()
	pass # Replace with function body.
