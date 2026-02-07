extends CanvasLayer
@onready var shop_admob: Admob = $ShopAdmob
var can_show_rewarded_ad: bool  = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop_admob.initialize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Control/ScrollContainer/VBoxContainer/HBoxContainer/HBoxContainer2/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/Power2.text = GameTimer.format_money(GameTimer.initial_power_collision)
	$Control/ScrollContainer/VBoxContainer/HBoxContainer/HBoxContainer/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/Power1.text = GameTimer.format_money(GameTimer.initial_power_antigravity)
	$Control/ScrollContainer/VBoxContainer/HBoxContainer3/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/key.text=GameTimer.format_money(GameTimer.initial_key_balance)
	
	
	$Control/ScrollContainer/VBoxContainer/HBoxContainer2/Panel/VBoxContainer/MarginContainer/VBoxContainer/Power1LebelTime.text='Level '+str(GameTimer.initial_power_antigravity_timer/2)+'('+str(GameTimer.initial_power_antigravity_timer)+')'
	
	
	$Control/ScrollContainer/VBoxContainer/HBoxContainer2/Panel2/VBoxContainer/MarginContainer/VBoxContainer/Power2LabelTime.text = 'Level '+str(GameTimer.initial_power_collision_timer/2)+'('+str(GameTimer.initial_power_collision_timer)+')'
	pass


func _on_texture_button_pressed() -> void:
	queue_free()
	pass # Replace with function body.



	
func _on_power_2_add_pressed() -> void:
	if GameTimer.initial_coin_balance > 999:
		GameTimer.add_power_collision()
		GameTimer.initial_coin_balance-=1000
	pass # Replace with function body.


func _on_power_1_add_pressed() -> void:
	
	if GameTimer.initial_coin_balance > 1999:
		GameTimer.add_power_antigravity()
		GameTimer.initial_coin_balance-=2000
	pass # Replace with function body.


func _on_key_add_pressed() -> void:
	if GameTimer.initial_coin_balance > 4999:
		GameTimer.add_power_antigravity()
		GameTimer.initial_coin_balance-=5000
	
	pass # Replace with function body.


func _on_power_2_add_time_pressed() -> void:
	if GameTimer.initial_coin_balance > 4999:
		GameTimer.add_power_antigravity()
		GameTimer.initial_coin_balance-=5000
	pass # Replace with function body.


func _on_power_1_add_t_ime_pressed() -> void:
	if GameTimer.initial_coin_balance > 4999:
		GameTimer.add_power_antigravity()
		GameTimer.initial_coin_balance-=5000
	pass # Replace with function body.


func _on_shop_admob_rewarded_ad_loaded(ad_info: AdInfo, response_info: ResponseInfo) -> void:
	can_show_rewarded_ad = true
	print("rewarded ad loaded")
	pass # Replace with function body.


func _on_shop_admob_initialization_completed(status_data: InitializationStatus) -> void:
	shop_admob.load_rewarded_ad()
	print('rewarded ad initialized')
	pass # Replace with function body.


func _on_show_rewarded_ad_pressed() -> void:
	if can_show_rewarded_ad:
		shop_admob.show_rewarded_ad()
	pass # Replace with function body.
