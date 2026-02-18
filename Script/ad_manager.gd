extends Node2D
@onready var ad_manager: Node2D = $"."
@onready var admob: Admob = $ShopAdmob
var callback: Callable
var onclose_ad: bool = false
var from_ad: String = ""

func _ready():
	#await get_tree().process_frame
	#await get_tree().create_timer(2.0).timeout
	admob.update_consent_info()
	

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
	

func _on_consent_form_loaded():
	pass

func _on_consent_form_dismissed():
	initialize_ads()

func initialize_ads():
	admob.initialize()
	

func show_rewarded_ad(local_callback: Callable, local_onclose:bool):
	print("i am here")
	admob.show_rewarded_ad()
	callback =local_callback
	onclose_ad = local_onclose
	

func _on_shop_admob_rewarded_ad_loaded(ad_info: AdInfo, response_info: ResponseInfo) -> void:
	pass # Replace with function body.


func _on_shop_admob_rewarded_ad_user_earned_reward(ad_info: AdInfo, reward_data: RewardItem) -> void:
	GameTimer.initial_coin_balance+=200
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
