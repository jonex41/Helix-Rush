extends Node3D

@onready var world_env := $WorldEnvironment
@onready var sky_mat: ShaderMaterial = (
	world_env.environment.sky.sky_material as ShaderMaterial
)
var level_block1 :Resource= preload("res://Scene/Levels/LevelSegments/level_block1.tscn")
var level_block2 :Resource= preload("res://Scene/Levels/LevelSegments/level_block2.tscn")
var level_block3 :Resource= preload("res://Scene/Levels/LevelSegments/level_block3.tscn")
var level_block4 : Resource= preload("res://Scene/Levels/LevelSegments/level_block4.tscn")
var level_block5 : Resource= preload("res://Scene/Levels/LevelSegments/level_block5.tscn")
var level_block6 : Resource= preload("res://Scene/Levels/LevelSegments/level_block6.tscn")
var level_block7 : Resource= preload("res://Scene/Levels/LevelSegments/level_block7.tscn")
var level_block8 : Resource= preload("res://Scene/Levels/LevelSegments/level_block8.tscn")
var level_block9 : Resource= preload("res://Scene/Levels/LevelSegments/level_block9.tscn")
var level_block10 : Resource= preload("res://Scene/Levels/LevelSegments/level_block10.tscn")
var level_block11 : Resource= preload("res://Scene/Levels/LevelSegments/level_block11.tscn")
var level_block12 : Resource= preload("res://Scene/Levels/LevelSegments/level_block12.tscn")
var level_block13 : Resource= preload("res://Scene/Levels/LevelSegments/level_block13.tscn")
var level_block14 : Resource= preload("res://Scene/Levels/LevelSegments/level_block14.tscn")
var level_block15 : Resource= preload("res://Scene/Levels/LevelSegments/level_block15.tscn")
var level_block16 : Resource= preload("res://Scene/Levels/LevelSegments/level_block16.tscn")
var level_block17 : Resource= preload("res://Scene/Levels/LevelSegments/level_block17.tscn")
var level_block18 : Resource= preload("res://Scene/Levels/LevelSegments/level_block18.tscn")
var level_block19 : Resource= preload("res://Scene/Levels/LevelSegments/level_block19.tscn")
var level_block20 : Resource= preload("res://Scene/Levels/LevelSegments/level_block20.tscn")
var level_block21 : Resource= preload("res://Scene/Levels/LevelSegments/level_block21.tscn")
var empty_block : Resource= preload("res://Scene/Levels/LevelSegments/empty_block.tscn")

var grid: Array = [
 [5,21],[4,6], [8,9],[7,8], [1,7],[6,4],[3,2],[1,3],[0,0],[9,2],[3,4],[8,2],[1,7],[5,9],[5,3],[8,10],[0,0],[11,7],[1,19],[17,5],[0,0],[3,1],[4,19],[14,11],[4,17],[15,5],[0,0],[18,17],[11,10],[17,14],[12,14],[11,4],[12,18],[9,6],[20,13],[18,10],[4,4],[17,13],[0,0],[3,19],[8,19],[4,2],[14,19],[9,4],[16,10],[17,20],[8,3],[10,5],[5,5],[3,13],[0,0],[12,2],[13,10],[1,12],[14,2],[10,13],[10,16],[18,2],[10,20],[3,7],[0,0],[0,0],[13,4],[2,2],[9,10],[5,18],[16,3],[11,17],[7,5],[15,7],[0,0],[12,11],[0,0],[0,0],[16,17],[7,13],[16,2],[19,10],[14,14],[20,16],[11,15],[2,15],[0,0],[1,2],[13,3],[9,7],[1,13],[2,6],[10,1],[1,10],[6,2],[2,3],[0,0],[1,14],[13,20],[13,13],[15,19],[11,2],[3,18],[4,7],[20,1],[11,20],[15,18],[2,10],[15,3],[11,5],[12,1],[6,17],[18,3],[2,19],[15,15],[6,19],[19,18],[12,16],[15,12],[15,1],[12,8],[18,16],[0,0],[20,20],[11,3],[18,19],[11,19],[14,1],[18,12],[17,12],[20,18],[7,8],[7,4],[6,6],[0,0],[3,15],[0,0],[16,11],[1,7],[10,7],[3,4],[6,15],[4,12],[6,18],[1,9],[8,12],[8,13],[13,5],[9,11],[17,2],[1,1],[19,4],[10,14],[17,7],[16,16],[10,9],[12,6],[0,0],[3,2],[19,15],[18,13],[17,11],[12,9],[8,7],[0,0],[18,6],[14,6],[15,4],[19,20],[8,17],[13,11],[2,18],[5,14],[6,7],[7,14],[0,0],[3,10],[13,8],[14,12],[12,12],[16,5],[10,3],[13,18],[15,20],[17,10],[5,2],[15,10],[19,14],[5,17],[14,18],[16,1],[0,0],[5,10],[6,13],[13,16],[10,12],[2,20],[20,19],[1,11],[12,13],[13,1],[4,5],[10,19],[5,11],[19,2],[16,13],[14,16],[6,3],[16,9],[9,3],[2,11],[13,14],[8,15],[8,4],[9,5],[8,6],[18,7],[6,5],[1,16],[1,8],[6,12],[17,17],[2,8],[5,20],[19,9],[1,3],[20,14],[4,3],[9,15],[20,11],[2,4],[3,17],[7,2],[3,6],[18,20],[6,1],[19,12],[17,4],[0,0],[0,0],[5,9],[3,9],[0,0],[12,3],[15,16],[14,3],[4,20],[5,15],[2,14],[14,8],[4,6],[16,4],[9,18],[1,5],[13,7],[11,13],[2,13],[5,7],[11,6],[5,12],[17,15],[2,17],[19,19],[19,13],[3,8],[18,1],[16,14],[19,5],[10,18],[16,19],[4,16],[17,19],[19,1],[19,8],[0,0],[20,8],[2,1],[7,20],[14,10],[13,12],[0,0],[12,15],[0,0],[4,1],[16,8],[6,16],[15,9],[12,7],[6,9],[20,3],[2,12],[20,7],[13,17],[17,18],[17,9],[14,4],[8,8],[9,16],[4,11],[1,17],[0,0],[9,8],[18,5],[11,18],[18,14],[8,5],[0,0],[14,20],[10,11],[2,5],[10,10],[19,7],[5,4],[14,7],[2,7],[16,12],[12,20],[7,7],[7,10],[10,4],[3,20],[3,16],[15,2],[10,8],[11,16],[18,4],[6,4],[1,20],[13,6],[15,8],[8,16],[13,2],[9,12],[7,6],[12,17],[8,2],[10,17],[0,0],[20,12],[1,15],[16,7],[8,11],[5,13],[1,4],[5,6],[11,11],[16,20],[7,3],[3,3],[13,19],[8,14],[15,6],[0,0],[11,14],[5,3],[0,0],[0,0],[17,3],[7,1],[6,11],[20,9],[20,10],[0,0],[16,15],[9,19],[0,0],[0,0],[8,1],[14,5],[19,17],[9,17],[4,15],[18,18],[0,0],[3,12],[0,0],[4,13],[7,16],[2,9],[8,20],[5,19],[13,15],[10,2],[17,6],[14,17],[9,9],[11,12],[4,10],[0,0],[1,6],[4,9],[3,14],[20,4],[17,8],[18,9],[0,0],[9,14],[2,16],[0,0],[7,18],[11,1],[15,11],[15,14],[19,3],[18,11],[16,18],[20,15],[11,9],[6,20],[5,16],[12,5],[8,18],[7,9],[11,8],[6,14],[20,5],[19,16],[7,12],[19,11],[5,1],[3,11],[18,15],[9,20],[16,6],[17,1],[17,16],[15,13],[0,0],[13,9],[0,0],[20,6],[10,15],[0,0],[6,8],[19,6],[9,2],[14,9],[6,10],[12,10],[18,8],[0,0],[12,8],[10,6],[9,1],[8,9],[15,17],[0,0],[4,14],[8,10],[7,17],[3,5],[7,11],[1,10],[20,17],[4,8],[5,8],[9,13],[7,15],[4,18]


]
var colorGrid = [

	["#2E3192",	"#1BFFFF"],
	[	"#D4145A"	,"#FBB03B"],
	[	"#009245",	"#FCEE21" ],
	[	"#11998E",	"#38EF7D"],
	[	"#FFECD2",	"#FCB69F"],
	[	"#00FF87",	"#60EFFF"],
	[	"#FF1B6B",	"#45CAFF"],
	[	"#40C9FF",	"#E81CFF"],
	[	"#FFA585",	"#FFEDA0"],
	[	"#9BAFD9",	"#103783"],
	[	"#82F4B1",	"#30C67C"],
	#chatgpt
	["#2193FF ","#6E3AFF"],
	["#FF512F",  "#DD2476"],
	["#00F5FF",  "#0061FF"],
	["#8E2DE2",  "#FF6FD8"],
	["#89F7FE",  "#66A6FF"],
	["#A8E6CF"  ,"#FDFFAB"],
	["#C3A3FF",  "#FFB7A5"],
	["#A1C4FD",  "#FBC2EB"],
	["#1A0638",  "#0F4C75"],
	["#000000",  "#8B0000"],
	["#0F2027",  "#2C5364"],
	["#00FF88" , "#001A12"],
	["#FFD200" , "#FF7A00"],
	["#FF416C" , "#FF4B2B"],
	["#00C6FF",  "#0072FF"],
	["#FF00CC" , "#333399"],
	["#56AB2F" , "#FBD786"],
	["#134E5E" , "#71B280"],
	["#5A3F37" , "#2C7744"],
	["#FFB347",  "#FFCC33" ,"#87CEEB"],
	["#FF5F6D",  "#FFC371"],
	["#8E2DE2"  ,"#FF6FD8" , "#FFD1DC"],
	["#FFAF7B" , "#FFD194" ,"#87CEFA"],
	["#87CEEB",  "#4FACFE"],
	["#00C6FF",  "#0072FF"],
	["#A1C4FD" , "#C2E9FB"],
	["#74B9FF",  "#0984E3"],
	["#FBD3A3",  "#87CEEB"],
	["#D7E1EC" , "#A3BDCC"],
	["#E0EAFC",  "#CFDEF3"],
	["#FF512F" , "#DD2476"],
	["#FF8008" , "#753A88"],
	["#FF416C" , "#FF4B2B" , "#1F1C2C"],
	["#FEC163",  "#DE4313"],
	["#2C5364",  "#203A43",  "#0F2027"],
	["#4B6CB7" , "#182848"],
	["#6A5ACD",  "#483D8B"],
	["#0F2027" ,"#203A43",  "#2C5364"],
	["#020024" , "#090979" , "#000000"],
	["#050A30" , "#000000"],
	["#BDC3C7" , "#2C3E50"],
	["#232526",  "#414345"],
	["#141E30" , "#243B55"],
	["#00C9FF" , "#92FE9D"],
	["#FBC2EB" , "#A6C1EE"],
	["#3A1C71" , "#D76D77",  "#FFAF7B"],
	["#41295A" , "#2F0743"],
	
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cycle_sky_gradient_new()
	spawn_level_block()
	
	
	pass # Replace with function body.
	
func cycle_sky_gradient_new() -> void:
	var total_pairs:float = colorGrid.size() 
	GameTimer.current_color_background =fmod( (GameTimer.current_color_background + 1) , total_pairs)
	sky_mat.set_shader_parameter("skyColor", Color.html(colorGrid[GameTimer.current_color_background][0]))
	sky_mat.set_shader_parameter("horizonColor", Color.html(colorGrid[GameTimer.current_color_background][1]))
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_3d_body_entered(_body: Node3D) -> void:
	GameTimer.set_is_playing(false) 
	var scene = preload("res://Scene/game_win_manager.tscn")
	var instance = scene.instantiate()
	GameTimer.initial_coin_balance += ScoreManager.score
	GameTimer.initial_key_balance += ScoreManager.key
	GameTimer.increase_level()
	GameTimer.set_is_playing(false) 

	
	$GameFinish/Area3D.set_deferred("monitoring", false)
	add_child(instance)
	pass # Replace with function body.

func show_hide_blink_screen(show:bool):
	$BlinkCanvasLayer.visible = true
	await get_tree().create_timer(2).timeout
	$BlinkCanvasLayer.visible = false
	
func spawn_level_block():
	var currentLevel = GameTimer.current_level-1
	
	print(grid.size())
	print("Level")
	print(str(currentLevel))
	var listOfBlocks = grid[currentLevel]
	
	for n in range(listOfBlocks.size()):
		print(listOfBlocks[n])
		if listOfBlocks[n]==1:
			addScenes(level_block1, n,currentLevel)
			pass
		if  listOfBlocks[n]==2:
			addScenes(level_block2, n,currentLevel)
			pass
		if  listOfBlocks[n]==3:
			addScenes(level_block3, n,currentLevel)
			pass
		if  listOfBlocks[n]==4:
			addScenes(level_block4, n,currentLevel)
			pass
		if  listOfBlocks[n]==5:
			addScenes(level_block5, n,currentLevel)
			pass
		if  listOfBlocks[n]==6:
			addScenes(level_block6, n,currentLevel)
			pass
		if  listOfBlocks[n]==7:
			addScenes(level_block7, n,currentLevel)
			pass
		if  listOfBlocks[n]==8:
			addScenes(level_block8, n,currentLevel)
			pass
		if  listOfBlocks[n]==9:
			addScenes(level_block9, n,currentLevel)
			pass
		if  listOfBlocks[n]==10:
			addScenes(level_block10, n,currentLevel)
			pass
		if  listOfBlocks[n]==11:
			addScenes(level_block11, n,currentLevel)
			pass
		if  listOfBlocks[n]==12:
			addScenes(level_block12, n,currentLevel)
			pass
		if  listOfBlocks[n]==13:
			addScenes(level_block13, n,currentLevel)
			pass
		if  listOfBlocks[n]==14:
			addScenes(level_block14, n,currentLevel)
			pass
		if  listOfBlocks[n]==15:
			addScenes(level_block15, n,currentLevel)
			pass
		if  listOfBlocks[n]==16:
			addScenes(level_block16, n,currentLevel)
			pass
		if  listOfBlocks[n]==17:
			addScenes(level_block17, n,currentLevel)
			pass
		if  listOfBlocks[n]==18:
			addScenes(level_block18, n,currentLevel)
			pass
		if  listOfBlocks[n]==19:
			addScenes(level_block19, n,currentLevel)
			pass
		if  listOfBlocks[n]==20:
			addScenes(level_block20, n,currentLevel)
			pass
		if  listOfBlocks[n]==21:
			addScenes(level_block21, n,currentLevel)
			pass
		if  listOfBlocks[n]==0:
			addScenes(empty_block, n,currentLevel)
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
func addScenes (scene : PackedScene,  index:int, currentLevel :int):
	var instance := scene.instantiate()
	var spawn_pos = $Node3D/Level/SpawnBlock1.global_position if index ==0 else $Node3D/Level/SpawnBlock2.global_position
	instance.global_position.y = spawn_pos.y
	if currentLevel % 11 == 0:
		instance.show_key_jetpack()
	else :
		instance.hide_key_jetpack()
	if currentLevel  == 0:
		instance.show_key_jetpack()
	add_child(instance)
	pass
