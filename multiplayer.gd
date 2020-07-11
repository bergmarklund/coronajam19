extends Node

var API_BASE_URL = "http://coronajam19.app.fernandobevilacqua.com/api"
var CREDENTIALS_FILE_PATH = "user://credentials.json"

# Declare member variables here. Examples:
var user_id = 2
var token = ""
var http_request = null

#
# API endpoits
#

func join():
	fetch(API_BASE_URL + "/join")
	
func test():
	fetch(API_BASE_URL + "/test")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_http_client()
	load_credentials_or_join()

func init_http_client():
	# Create an HTTP request node and connect its completion signal.
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_on_request_completed")
	
	
func has_credentials():
	var credentials = File.new()
	return credentials.file_exists(CREDENTIALS_FILE_PATH)
	
# Load credentials (if they exist) or join a game
func load_credentials_or_join():
	if not has_credentials():
		join();
		return

	var credentials_file = File.new()	
	credentials_file.open(CREDENTIALS_FILE_PATH, File.READ)
	
	var credentials = parse_json(credentials_file.get_as_text())
	print(credentials)

func fetch(url):
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
