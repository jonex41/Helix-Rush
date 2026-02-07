extends Control

var http_request: HTTPRequest
var firebase_project_id = "schoolschool-3d356" # Your project ID
var id_token = "YOUR_FIREBASE_ID_TOKEN" # Replace with the actual ID token


func _ready():
	http_request = $HTTPRequest # Get the HTTPRequest node
	http_request.request_completed.connect(self._on_http_request_completed)

func read_data(path: String):
	var url = "https://%s.firebaseio.com/%s.json?auth=%s" % [firebase_project_id, path, id_token]
	var headers = ["Content-Type: application/json"]
	print("Reading from URL: ", url)
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)
	if error != OK:
		print("Error initiating GET request: ", error)

func _on_http_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	if response_code == 200:
		var json_string = body.get_string_from_utf8()
		var json_result = JSON.parse_string(json_string)
		if json_result is Dictionary or json_result is Array:
			print("Read data: ", json_result)
		else:
			print("Raw response: ", json_string)
	else:
		print("Error reading data. Response Code: ", response_code)
		print("Response Body: ", body.get_string_from_utf8())

# Example usage:
func _input(event):
	if event.is_action_pressed("ui_accept"): # Press Enter to trigger
		read_data("users/alanisawesome") # Read data about 'alanisawesome'
