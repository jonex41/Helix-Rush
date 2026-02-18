extends Control
signal selected(data)

@onready var button := $Button
var cell_data: Dictionary
@export var display_name := ""
@export var icon: Texture2D
@export var cost := 0

@onready var name_label: Label = $VBoxContainer/Label
@onready var icon_rect: TextureRect = $VBoxContainer/TextureRect
@onready var cost_label: Label = $VBoxContainer/Cost


func setup(data: Dictionary):
	cell_data = data
	var value 
	if data.cost is int or data.cost is float:
		value =   "Coins "+GameTimer.format_money(data.cost)
		
	else:
		value = data.cost
		 
	$VBoxContainer/TextureRect.size = Vector2(50, 50)

	$VBoxContainer/Label.text =  data.name
	$VBoxContainer/TextureRect.texture = data.icon
	$VBoxContainer/Cost.text = value
	
	if data.is_selected:
		$ColorRect2.visible = true
	else :
		$ColorRect2.visible = false
	if data.is_open :
		#$ColorRect.visible = false
		$TextureRect.visible = false
		
func _ready():
	button.pressed.connect(func():
		selected.emit(cell_data))
	
