extends RigidBody3D

@onready var bounce_sound: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var min_impact_speed := 2.0
@export var cooldown := 0.05

#getting count


var last_velocity_y := 0.0
var bounce_cooldown := false



# Tune this (VERY IMPORTANT)
@export var min_bounce_velocity := 0.05

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

		# Must be a TOP surface
		if normal.dot(Vector3.UP) < 0.6:
			continue

		# Detect velocity direction flip (DOWN → UP)
		var vy := linear_velocity.y

		if  vy > min_bounce_velocity:
			GameTimer.increase_ball_bounce()
			bounce_cooldown = true
			
			break





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
		print('i am here nw color')
		body.change_color()
	pass # Replace with function body.
