extends Control


var can_show_rewarded_ad: bool  = false
var my_has_spin:bool = false
@onready var admob: Admob = $ShopAdmob


# Use Node3D if this is 3D (see note below)

func _ready() -> void:
	if admob.is_consent_form_available():
		print("yes it is , else no")
		admob.update_consent_info()
	else :
		admob.initialize()
		print("no it not")
	EventBus.send_has_spin.connect(has_spin_wheel)

func has_spin_wheel(has_spin, is_key):
	my_has_spin= has_spin
	#$Button.text = "Spin Again" if has_spin else "Spinning"
	if has_spin:
		$Button/HBoxContainer/TextureRect.visible = true
	else :
		$Button/HBoxContainer/TextureRect.visible = false
	pass

func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if my_has_spin== false:
		spin_wheel()
	else:
		print('spin for ad')
		AdManager.show_rewarded_ad(spin_wheel, true)
		#shop_admob.show_rewarded_ad()
	
	pass # Replace with function body.

func spin_wheel():
	$CenterContainer/SpiningWheel.spin_wheel()

func _on_texture_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
	
	

	
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
	spin_wheel()
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
	


func _on_shop_admob_rewarded_ad_showed_full_screen_content(ad_info: AdInfo) -> void:
	pass # Replace with function body.
