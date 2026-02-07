extends CanvasLayer

@export var target_path: NodePath
@onready var target := get_node(target_path)
@onready var item_list: ItemList = $Control/VBoxContainer/ItemList

var cells := []
var scenes := [
	{	
		"id": 0,
		"name": "Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/round_ball.png"),
		"cost": "",
		"is_open":true
	},
	
		{
		"id": 1,
		"name": "Square Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/square_ball.png"),
		"cost": "Level 3",
		"is_open":true if GameTimer.current_level >= 3 else false

	},
	
		{
		"id": 2,
		"name": "Rugby Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/rubgy.png"),
		"cost": 20000,
		"is_open":true
	},
	
	{
		"id": 3,
		"name": "Coin Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/Atlas/COIN.PNG"),
		"cost": 30000,
		"is_open":true
	},
	
		
	{
		"id": 4,
		"name": "Monkey Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/monkey.png"),
		"cost": 30000,
		"is_open":true
	},



]
# Called when the node enters the scene tree for the first time.
@onready var grid: GridContainer = $Control/VBoxContainer/GridContainer
var cell_scene := preload( "res://Scene/skin_single_display.tscn")

func _ready():
	populate_grid()

func populate_grid():
	cells.clear()
	

	for data in scenes:
		var cell := cell_scene.instantiate()
		cell.setup(data)
		cell.selected.connect(_on_cell_selected)
		grid.add_child(cell)
		cells.append(cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_cancel_pressed() -> void:
	queue_free()
	pass # Replace with function body.





func _on_texture_button_pressed() -> void:
	queue_free()
	pass # Replace with function body.
func _on_cell_selected(data: Dictionary):
	#var instance = data.scene.instantiate()
	#instance.setup(data)
	#add_child(instance)
	
	
	print(data.name)
	if !data.is_open:
		if data.cost is int or  data.cost is float:
			if GameTimer.initial_coin_balance >= data.cost:
				GameTimer.initial_coin_balance= GameTimer.initial_coin_balance - data.cost 
				var index = find_index_by_id(data.id)
				scenes[index].is_open = true
				var my_data =data
				my_data.is_open = true
				cells[index].setup(my_data)
			
				#scene.s
			else:
				return
				
					
			
		else:
			return
	var nameBall = data.name
	if nameBall == 'Square Ball':
		
		GameTimer.selectedBallScene ="res://Scene/Balls/square.tscn"
	elif nameBall == 'Rugby Ball':
		
		GameTimer.selectedBallScene ="res://Scene/Balls/football_ruggy.tscn"
		
	elif nameBall == 'Ball' :
		GameTimer.selectedBallScene = "res://Scene/Balls/ball.tscn"
	elif nameBall == 'Coin Ball' :
		GameTimer.selectedBallScene = "res://Scene/Balls/coin_ball.tscn"
		
	elif nameBall == 'Monkey Ball' :
		GameTimer.selectedBallScene = "res://Scene/Balls/monkey_ball.tscn"
		
		
		#target.set_scene(GameTimer.selectedBallScene)
		#target.spawn()
	get_tree().call_group("Player", "free_palayer")
	get_tree().call_group("SpawnPoint", "set_scene",GameTimer.selectedBallScene)
	get_tree().call_group("SpawnPoint", "spawn")
func find_index_by_id(id: int) -> int:
	for i in cells.size():
		if scenes[i].id == id:
			return i
	return -1
