extends Node2D
@onready var admob: Admob = $Admob


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	admob.initialize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_admob_initialization_completed(status_data: InitializationStatus) -> void:
	admob.load_rewarded_interstitial_ad()
	admob.load_rewarded_ad()
	admob.load_banner_ad()
	pass # Replace with function body.


func _on_admob_rewarded_ad_loaded(ad_info: AdInfo, response_info: ResponseInfo) -> void:
	admob.show_rewarded_ad()
	pass # Replace with function body.
