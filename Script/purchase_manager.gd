extends Node

const PRODUCT_ID_5000 = "coin_5000"
const PRODUCT_ID_20000 = "coin20000"
const PRODUCT_ID_40000 = "coin40000"
const PRODUCT_ID_100000 = "coin100000"
const PRODUCT_ID_removead = "remove_ads_forever"
const PRODUCT_ID_supportdev = "support_developer"

var billing
var is_ready := false
var remove_ads_unlocked := false

func _ready():
	# Get billing singleton
	billing = BillingClient.new()
	# Connect signal
	billing.connected.connect(_on_connected)
	billing.disconnected.connect(_on_disconnected)
	billing.connect_error.connect(_on_connect_error)
	billing.on_purchase_updated.connect(_on_purchase_updated)
	billing.query_product_details_response.connect(_on_query_product_details_response) # response: Dictionary
	billing.query_purchases_response.connect(_on_query_purchases_response)
	billing.start_connection()


# =========================
# CONNECTION
# =========================
func _on_connected():
	print("Billing Connected ✅")
	is_ready = true

	# Restore purchases automatically
	
	#billing.query_purchases("inapp")
	billing.query_purchases(BillingClient.ProductType.INAPP)
	billing.query_product_details([PRODUCT_ID_5000, PRODUCT_ID_20000, PRODUCT_ID_40000, PRODUCT_ID_100000, PRODUCT_ID_removead], BillingClient.ProductType.INAPP) # BillingClient.ProductType.SUBS for subscriptions.

func _on_disconnected():
	print("Billing Disconnected ❌")
	is_ready = false

func _on_query_product_details_response(query_result: Dictionary):
	if query_result.response_code == BillingClient.BillingResponseCode.OK:
		print("Product details query success")
		for available_product in query_result.product_details:
			print(available_product)
	else:
		print("Product details query failed")
		print("response_code: ", query_result.response_code, "debug_message: ", query_result.debug_message)


func _on_connect_error(error):
	print("Connection Error: ", error)

# =========================
# PURCHASE
# =========================
func buy_remove_ads():
	if not is_ready:
		print("Billing not ready")
		return
	print("Starting purchase...")
	billing.purchase(PRODUCT_ID_removead)
	
func buy_coin_5000():
	if not is_ready:
		print("Billing not ready")
		return
	print("Starting purchase...")
	billing.purchase(PRODUCT_ID_5000)
	
func buy_coin_20000():
	if not is_ready:
		print("Billing not ready")
		return
	print("Starting purchase...")
	billing.purchase(PRODUCT_ID_20000)
	
	
func buy_coin_40000():
	if not is_ready:
		print("Billing not ready")
		return
	print("Starting purchase...")
	billing.purchase(PRODUCT_ID_40000)
 

	
func buy_coin_100000():
	if not is_ready:
		print("Billing not ready")
		return
	print("Starting purchase...")
	billing.purchase(PRODUCT_ID_100000)

func buy_support_dev():
	if not is_ready:
		print("Billing not ready")
		return
	print("Starting purchase...")
	billing.purchase(PRODUCT_ID_supportdev)

# =========================
# HANDLE PURCHASE RESULT
# =========================
func _on_purchase_updated(result):
	if result.response_code == BillingClient.BillingResponseCode.OK:
		for purchase in result.purchases:
			_process_purchase(purchase)
	else:
		print("Purchase update error")
		print("response_code: ", result.response_code, "debug_message: ", result.debug_message)
		
	
	
func _process_purchase(purchases):
	var products = purchases.product_ids
	if PRODUCT_ID_removead in products:
		update(purchases,PRODUCT_ID_removead )
	elif PRODUCT_ID_5000 in products:
		update(purchases,PRODUCT_ID_5000)
	elif PRODUCT_ID_20000 in products:
		update(purchases,PRODUCT_ID_20000)
	elif PRODUCT_ID_40000 in products:
		update(purchases,PRODUCT_ID_40000)
	elif PRODUCT_ID_100000 in products:
		update(purchases,PRODUCT_ID_100000)
	elif PRODUCT_ID_supportdev in products:
		update(purchases,PRODUCT_ID_supportdev)

			
			
func update(purchase, product_id):
	var state = purchase.purchase_state
	var acknowledged = purchase.is_acknowledged
			# PURCHASED
	if state == BillingClient.PurchaseState.PURCHASED:
		print("Purchase success 🎉")
		#remove_ads_unlocked = true
		_save_purchase(product_id)
				# MUST acknowledge (VERY IMPORTANT)
		if product_id == PRODUCT_ID_removead:
			if not acknowledged:
				billing.acknowledge_purchase(purchase.purchase_token)
		else :
			if not acknowledged:
				billing.consume_purchase(purchase.purchase_token)
			

# =========================
# SAVE / LOAD
# =========================
func _save_purchase(product_id):
	#var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	#file.store_var(remove_ads_unlocked)
	if product_id == PRODUCT_ID_5000:
		GameTimer.update_initial_coin_balance(5000, false)
		pass
	elif product_id == PRODUCT_ID_20000:
		GameTimer.update_initial_coin_balance(20000, false)
		pass
	elif product_id == PRODUCT_ID_40000:
		GameTimer.update_initial_coin_balance(40000, false)
		pass
	elif product_id == PRODUCT_ID_100000:
		GameTimer.update_initial_coin_balance(100000, false)
		pass
	elif product_id == PRODUCT_ID_supportdev:
		GameTimer.update_initial_coin_balance(100000, false)
		pass
	elif product_id == PRODUCT_ID_removead:
		GameTimer.is_allow_ads(false)
		pass
	
func _on_query_purchases_response( result):
	if result.response_code == BillingClient.BillingResponseCode.OK:
		for purchase in result.purchases:
			_process_purchase(purchase)
	else:
		print("Purchase update error")
		print("response_code: ", result.response_code, "debug_message: ", result.debug_message)
		

	
func load_purchase():
	if FileAccess.file_exists("user://save.dat"):
		var file = FileAccess.open("user://save.dat", FileAccess.READ)
		remove_ads_unlocked = file.get_var()

# =========================
# HELPER
# =========================
func should_show_ads() -> bool:
	return not remove_ads_unlocked
