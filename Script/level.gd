extends Node3D
var level_block1 := preload("res://Scene/Levels/LevelSegments/level_block1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_level_block()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_3d_body_entered(_body: Node3D) -> void:
	#GameTimer.set_is_playing(false) 
	#var scene = preload("res://Scene/game_win.tscn")
	#var instance = scene.instantiate()
	#add_child(instance)
	pass # Replace with function body.

func show_hide_blink_screen(show:bool):
	$BlinkCanvasLayer.visible = true
	await get_tree().create_timer(2).timeout
	$BlinkCanvasLayer.visible = false
	
func spawn_level_block():
	var instance := level_block1.instantiate()
	var spawn_pos = $Node3D/Level/LevelBlock1.global_position
	instance.global_position.y = spawn_pos.y
	add_child(instance)
	
	var instance2 := level_block1.instantiate()
	var spawn_pos1 = $Node3D/Level/LevelBlock2.global_position
	instance2.global_position.y = spawn_pos1.y
	add_child(instance2)
	
	var instance3 := level_block1.instantiate()
	var spawn_pos2 = $Node3D/Level/LevelBlock3.global_position
	instance3.global_position.y = spawn_pos2.y
	add_child(instance3)
	pass
