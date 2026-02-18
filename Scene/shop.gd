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
		GameTimer.update_initial_coin_balance(1000, true)
	pass # Replace with function body.


func _on_power_1_add_pressed() -> void:
	
	if GameTimer.initial_coin_balance > 1999:
		GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(2000, true)
	pass # Replace with function body.


func _on_key_add_pressed() -> void:
	if GameTimer.initial_coin_balance > 4999:
		GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(5000, true)
	
	pass # Replace with function body.


func _on_power_2_add_time_pressed() -> void:
	if GameTimer.initial_coin_balance > 4999:
		GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(5000, true)
	pass # Replace with function body.


func _on_power_1_add_t_ime_pressed() -> void:
	if GameTimer.initial_coin_balance > 4999:
		GameTimer.add_power_antigravity()
		
		GameTimer.update_initial_coin_balance(5000, true)
	pass # Replace with function body.





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
	
