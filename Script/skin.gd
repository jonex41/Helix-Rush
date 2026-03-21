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
		"icon": preload("res://Assets/ball image/beach_ball.png"),
		"cost": "",
		"is_open":true,
		"is_selected":true if   "res://Scene/Balls/ball.tscn" == GameTimer.selectedBallScene else false
	},
	
		{
		"id": 1,
		"name": "Square Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/square_ball.png"),
		"cost": "Level 3",
		"is_open":true if GameTimer.current_level >= 3 else false,
		"is_selected":true if  "res://Scene/Balls/square.tscn" == GameTimer.selectedBallScene else false

	},
	
		{
		"id": 2,
		"name": "Rugby Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/rubgy2.tga"),
		"cost": 20000,
		"is_open":GameTimer.is_bought_rugby_ball,
		"is_selected":true if  "res://Scene/Balls/football_ruggy.tscn" == GameTimer.selectedBallScene else false
	},
	
	{
		"id": 3,
		"name": "Coin Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/Atlas/COIN.PNG"),
		"cost": 30000,
		"is_open":GameTimer.is_bought_coin_ball,
		"is_selected":true if "res://Scene/Balls/coin_ball.tscn" == GameTimer.selectedBallScene else false
	},
	
		
	{
		"id": 4,
		"name": "Monkey Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/monkey.png"),
		"cost": 30000,
		"is_open":GameTimer.is_bought_monkey_ball,
		"is_selected":true if  "res://Scene/Balls/monkey_ball.tscn" == GameTimer.selectedBallScene else false
	},
	
	{
		"id": 5,
		"name": "Base Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/baseball.png"),
		"cost": 30000,
		"is_open":GameTimer.is_bought_base_ball,
		"is_selected":true if  "res://Scene/Balls/baseball.tscn" == GameTimer.selectedBallScene else false
	},
	
	{
		"id": 6,
		"name": "Soccer Ball",
		"scene": preload( "res://Scene/skin_single_display.tscn"),
		"icon": preload("res://Assets/ball image/soccerball.png"),
		"cost": 40000,
		"is_open":GameTimer.is_bought_soccer_ball,
		"is_selected":true if  "res://Scene/Balls/soccer_ball.tscn" == GameTimer.selectedBallScene else false
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
				if data.name == "Coin Ball":
					GameTimer.bought_coin_ball()
					pass
				elif data.name == "Rugby Ball":
					GameTimer.bought_rugby_ball()
					pass
				elif data.name == "Monkey Ball":
					GameTimer.bought_monkey_ball()
					pass
				elif data.name == "Base Ball":
					GameTimer.bought_base_ball()
					pass
				elif data.name == "Soccer Ball":
					GameTimer.bought_soccer_ball()
					pass
				var index = find_index_by_id(data.id)
				scenes[index].is_open = true
				var my_data =data
				my_data.is_open = true
				cells[index].setup(my_data)
			
				#scene.s
			else:
				show_insufficency()
				return
				
					
			
		else:
			return
	var nameBall = data.name
	if nameBall == 'Square Ball':
		
		GameTimer.selected_ball("res://Scene/Balls/square.tscn")
	elif nameBall == 'Rugby Ball':
		
		GameTimer.selected_ball("res://Scene/Balls/football_ruggy.tscn")
		
	elif nameBall == 'Ball' :
		GameTimer.selected_ball( "res://Scene/Balls/ball.tscn")
	elif nameBall == 'Coin Ball' :
		GameTimer.selected_ball( "res://Scene/Balls/coin_ball.tscn")
		
	elif nameBall == 'Monkey Ball' :
		GameTimer.selected_ball("res://Scene/Balls/monkey_ball.tscn")
	elif nameBall == 'Base Ball' :
		GameTimer.selected_ball("res://Scene/Balls/baseball.tscn")
			
	elif nameBall == 'Soccer Ball' :
		GameTimer.selected_ball("res://Scene/Balls/soccer_ball.tscn")
			
			
		#target.set_scene(GameTimer.selectedBallScene)
		#target.spawn()
	get_tree().call_group("Player", "free_palayer")
	get_tree().call_group("SpawnPoint", "set_scene",GameTimer.selectedBallScene)
	get_tree().call_group("SpawnPoint", "spawn")
	var index = find_index_by_id(data.id)
	for i in cells.size():
		if index == i:
			scenes[index].is_selected = true
			var my_data =data
			my_data.is_selected = true
			cells[index].setup(my_data)
		else :
			scenes[i].is_selected = false
			
			cells[i].setup(scenes[i])
			
func find_index_by_id(id: int) -> int:
	for i in cells.size():
		if scenes[i].id == id:
			return i
	return -1
func show_insufficency():
	var scene = preload("res://Scene/Ui/insufficient_bal.tscn")
	var instance = scene.instantiate()
	add_child(instance)
