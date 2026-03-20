extends CanvasLayer

@onready var admob: Admob = $ShopAdmob

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if admob.is_consent_form_available():
		print("yes it is , else no")
		admob.update_consent_info()
	else :
		admob.initialize()
		print("no it not")
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Control/ScrollContainer/VBoxContainer/HBoxContainer/HBoxContainer2/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/Power2.text = str(GameTimer.initial_power_collision)
	$Control/ScrollContainer/VBoxContainer/HBoxContainer/HBoxContainer/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/Power1.text =str( GameTimer.initial_power_antigravity)
	$Control/ScrollContainer/VBoxContainer/HBoxContainer3/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/key.text=str(GameTimer.initial_key_balance)
	
	
	$Control/ScrollContainer/VBoxContainer/HBoxContainer2/Panel/VBoxContainer/MarginContainer/VBoxContainer/Power1LebelTime.text='Level '+str(get_the_level(GameTimer.initial_power_antigravity_timer))+'('+str(GameTimer.initial_power_antigravity_timer)+')'
	
	
	$Control/ScrollContainer/VBoxContainer/HBoxContainer2/Panel2/VBoxContainer/MarginContainer/VBoxContainer/Power2LabelTime.text = 'Level '+str(get_the_level(GameTimer.initial_power_collision_timer))+'('+str(GameTimer.initial_power_collision_timer)+')'
	$Control/ScrollContainer/VBoxContainer/HBoxContainer2/Panel/VBoxContainer/MarginContainer/VBoxContainer/Power1Label.text = str(GameTimer.format_money( get_the_cost(GameTimer.initial_power_antigravity_timer)))
	$Control/ScrollContainer/VBoxContainer/HBoxContainer2/Panel2/VBoxContainer/MarginContainer/VBoxContainer/Power2Label.text = str(GameTimer.format_money(get_the_cost(GameTimer.initial_power_collision_timer)))
	pass

func get_the_cost(time:int)->int:
	if time == 3:
		return 3000
	elif time == 5:
		return 7000
	elif time == 7:
		return 14000	
	else:
		return 100000000000
		
func get_the_level(time:int)->int:
	if time == 3:
		return 1
	elif time == 5:
		return 2
	elif time == 7:
		return 3	
	else:
		return 3	

func increase_the_time(time:int)->int:
	if time == 3:
		return 5
	elif time == 5:
		return 7
	elif time == 7:
		return 9	
	else:
		return 9

func _on_texture_button_pressed() -> void:
	queue_free()
	pass # Replace with function body.



	
func _on_power_2_add_pressed() -> void:
	if int( GameTimer.initial_coin_balance) > 1999:
		GameTimer.add_power_collision()
		GameTimer.update_initial_coin_balance(2000, true)
	else :
		show_insufficency()
	pass # Replace with function body.


func _on_power_1_add_pressed() -> void:
	
	if int(GameTimer.initial_coin_balance) > 2999:
		GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(3000, true)
	else :
		show_insufficency()
	pass # Replace with function body.


func _on_key_add_pressed() -> void:
	if int(GameTimer.initial_coin_balance) > 4999:
		GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(5000, true)
		GameTimer.add_power_key()
	else :
		show_insufficency()
	pass # Replace with function body.


func _on_power_2_add_time_pressed() -> void:
	if GameTimer.initial_power_collision_timer == 9:
		return
	if int(GameTimer.initial_coin_balance) > (get_the_cost(GameTimer.initial_power_collision_timer)-1):
		#GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(get_the_cost(GameTimer.initial_power_collision_timer), true)
		GameTimer.increase_initial_power_collision_timer ( increase_the_time(GameTimer.initial_power_collision_timer))
	else :
		show_insufficency()
	pass # Replace with function body.


func _on_power_1_add_t_ime_pressed() -> void:
	if GameTimer.initial_power_antigravity_timer == 9:
		return
	if int(GameTimer.initial_coin_balance) > (get_the_cost(GameTimer.initial_power_antigravity_timer)-1):
		#GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(get_the_cost(GameTimer.initial_power_antigravity_timer), true)
		GameTimer.increase_initial_power_antigravity_timer(increase_the_time(GameTimer.initial_power_antigravity_timer))
	else :
		show_insufficency()
	pass # Replace with function body.


func show_insufficency():
	var scene = preload("res://Scene/Ui/insufficient_bal.tscn")
	var instance = scene.instantiate()
	add_child(instance)




func _on_show_rewarded_ad_pressed() -> void:
	print("show-ads")
	admob.show_rewarded_ad()

	pass # Replace with function body.


func admob_remard():
	GameTimer.update_initial_coin_balance(200, false)
	print("have watched video")
	
	
	
	
func _on_shop_admob_rewarded_ad_loaded(ad_info: AdInfo, response_info: ResponseInfo) -> void:
	pass # Replace with function body.


func _on_shop_admob_rewarded_ad_user_earned_reward(ad_info: AdInfo, reward_data: RewardItem) -> void:

	pass # Replace with function body.


func _on_shop_admob_consent_form_loaded() -> void:
	admob.show_consent_form()
	pass # Replace with function body.


func _on_shop_admob_initialization_completed(status_data: InitializationStatus) -> void:
	print("load ad")
	admob.load_rewarded_ad()
	pass # Replace with function body.


func _on_shop_admob_rewarded_ad_dismissed_full_screen_content(ad_info: AdInfo) -> void:

	pass # Replace with function body.


func _on_shop_admob_consent_info_updated() -> void:
	_process_consent_status()
	pass # Replace with function body.



func request_consent():
	admob.reset_consent_info()

func _process_consent_status() -> void:
	
	#_print_to_screen("_process_consent_status(): consent status = %s" % _consent_status)
	match admob.get_consent_status():
		UserConsent.Status.UNKNOWN:
			print("unkown")
			
			admob.update_consent_info()
		UserConsent.Status.NOT_REQUIRED:
			print("not required")
			admob.initialize()
		UserConsent.Status.REQUIRED:
			print("required")
			#_print_to_screen("consent is required")
			admob.load_consent_form()
		UserConsent.Status.OBTAINED:
			print("obtained")
			#_print_to_screen("consent has been obtained")
			
			admob.initialize()
	


func _on_texture_rect_remove_ad_pressed() -> void:
	goto_not_avialable()
	pass # Replace with function body.


func _on_texture_rect_2100000000_pressed() -> void:
	goto_not_avialable()
	pass # Replace with function body.


func _on_texture_rect_40000_pressed() -> void:
	goto_not_avialable()
	pass # Replace with function body.


func _on_texture_rect_20000_pressed() -> void:
	goto_not_avialable()
	pass # Replace with function body.


func _on_texture_rect_5000_pressed() -> void:
	goto_not_avialable()
	pass # Replace with function body.
func goto_not_avialable():
	var scene = preload("res://Scene/Ui/not_available.tscn")
	var instance = scene.instantiate()
	
	add_child(instance)
