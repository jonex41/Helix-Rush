extends Node3D
var level_block1 :Resource= preload("res://Scene/Levels/LevelSegments/level_block1.tscn")
var level_block2 :Resource= preload("res://Scene/Levels/LevelSegments/level_block2.tscn")
var level_block3 :Resource= preload("res://Scene/Levels/LevelSegments/level_block3.tscn")
var level_block4 : Resource= preload("res://Scene/Levels/LevelSegments/level_block4.tscn")
var level_block5 : Resource= preload("res://Scene/Levels/LevelSegments/level_block5.tscn")
var level_block6 : Resource= preload("res://Scene/Levels/LevelSegments/level_block6.tscn")
var level_block7 : Resource= preload("res://Scene/Levels/LevelSegments/level_block7.tscn")
var level_block8 : Resource= preload("res://Scene/Levels/LevelSegments/level_block8.tscn")
var grid: Array = [
	[8,2],
	[2, 1],
	[3, 2],
	[1,3],
	[2,2]
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_level_block()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_3d_body_entered(_body: Node3D) -> void:
	GameTimer.set_is_playing(false) 
	var scene = preload("res://Scene/game_win.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	pass # Replace with function body.

func show_hide_blink_screen(show:bool):
	$BlinkCanvasLayer.visible = true
	await get_tree().create_timer(2).timeout
	$BlinkCanvasLayer.visible = false
	
func spawn_level_block():
	var currentLevel = GameTimer.current_level
	var listOfBlocks = grid[currentLevel-1]
	for n in range(listOfBlocks.size()):
		if listOfBlocks[n]==1:
			addScenes(level_block1, n)
			pass
		if  listOfBlocks[n]==2:
			addScenes(level_block2, n)
			pass
		if  listOfBlocks[n]==3:
			addScenes(level_block3, n)
			pass
		if  listOfBlocks[n]==4:
			addScenes(level_block4, n)
			pass
		if  listOfBlocks[n]==5:
			addScenes(level_block5, n)
			pass
		if  listOfBlocks[n]==6:
			addScenes(level_block6, n)
			pass
		if  listOfBlocks[n]==7:
			addScenes(level_block7, n)
			pass
		if  listOfBlocks[n]==8:
			addScenes(level_block8, n)
			pass
		if  listOfBlocks[n]==9:
			#addScenes(level_block9, n)
			pass
		if  listOfBlocks[n]==10:
			#addScenes(level_block10, n)
			pass
		
	
	
	
	
	#$var instance2 := level_block1.instantiate()
	#var spawn_pos1 = $Node3D/Level/LevelBlock2.global_position
	#instance2.global_position.y = spawn_pos1.y
	#add_child(instance2)
	
	#var instance3 := level_block1.instantiate()
	#var spawn_pos2 = $Node3D/Level/LevelBlock3.global_position
	#instance3.global_position.y = spawn_pos2.y
	#add_child(instance3)
	pass
func addScenes (scene : PackedScene,  index:int):
	var instance := scene.instantiate()
	var spawn_pos = $Node3D/Level/SpawnBlock1.global_position if index ==0 else $Node3D/Level/SpawnBlock2.global_position
	instance.global_position.y = spawn_pos.y
	add_child(instance)
	pass
