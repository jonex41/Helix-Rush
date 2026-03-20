extends CanvasLayer


@onready var admob: Admob = $ShopAdmob


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset()
	$VBoxContainer/HBoxContainer/WordPress2.text = '('+str(GameTimer.initial_key_balance)+')'
	if admob.is_consent_form_available():
		print("yes it is , else no")
		admob.update_consent_info()
	else :
		admob.initialize()
		print("no it not")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	


func _on_no_thanks_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	admob.show_rewarded_ad()
	pass # Replace with function body.


func _on_word_press_pressed() -> void:
	revive_game()
		
	pass # Replace with function body.


func _on_key_press_pressed() -> void:
	revive_game()
	pass # Replace with function body.
	
func revive_game()->void:
	if GameTimer.initial_key_balance >0:
		print("i am here 2")
		GameTimer.reduce_power_key()
		GameTimer.puase_lossing_stat()
		
		var balls := get_tree().get_nodes_in_group("Player")
		if balls.size() > 0:
			var rb: RigidBody3D = balls[0]
			rb.freeze = false
			rb.apply_impulse(Vector3.UP * 5)
		GameTimer.disable_rotation_input= false

		queue_free()
	else :
		get_tree().reload_current_scene()
		print("i am here 23")
		#var scene = preload("res://Scene/shop.tscn")
		#var instance = scene.instantiate()
		#get_tree().current_scene.add_child(instance)
		#queue_free()




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
	revive_game()
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
	


func _on_shop_admob_rewarded_interstitial_ad_dismissed_full_screen_content(ad_info: AdInfo) -> void:
	pass # Replace with function body.
