extends Node

var API_BASE_URL = "http://coronajam19.app.fernandobevilacqua.com/api"
var CREDENTIALS_FILE_PATH = "user://credentials.json"

# Declare member variables here. Examples:
var user_id = 0
var token = ""
var ship = {}
var messages = {}
var http_request = null

#
# API endpoits
#

func join():
	fetch(API_BASE_URL + "/join")
	
func move(direction):
	var valid_direction = direction == "up" || direction == "down" || direction == "left" || direction == "right"
	if !valid_direction:
		printerr("[Multiplayer] invalid direction for move: " + direction + ". Use either up, down, left or right.")
		return
		
	fetch_with_credentials(API_BASE_URL + "/move/" + direction)
	
func warp(row, col):
	fetch_with_credentials(API_BASE_URL + "/warp/" + String(row) + "/" + String(col))
	
func message(content):
	fetch_with_credentials(API_BASE_URL + "/message/" + content.percent_encode())
	
func test():
	fetch(API_BASE_URL + "/test")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print("[Multiplayer] client starting")
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
	
func save_credentials(content):
	var credentials = JSON.print(content);
	var credentials_file = File.new()
	
	credentials_file.open(CREDENTIALS_FILE_PATH, File.WRITE)
	credentials_file.store_string(credentials)
	
	print("[Multiplayer] credentials saved locally: " + credentials)
	
func load_credentials_or_join():
	if not has_credentials():
		join();
		return
	load_credentials()
	
func load_credentials():
	var credentials_file = File.new()	
	credentials_file.open(CREDENTIALS_FILE_PATH, File.READ)
	
	var obj = JSON.parse(credentials_file.get_as_text())
	var credentials = obj.result;

	print("[Multiplayer] found stored credentials: " + JSON.print(credentials))

	user_id = credentials.id
	token = credentials.token

func fetch_with_credentials(url):
	fetch(url + "/" + String(user_id) + "/" + token)

func fetch(url):
	print("[Multiplayer] fetch: " + url)
	
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var action = json.result.action
	
	print("[Multiplayer] response received: " + JSON.print(json.result))
	
	if action == "join":
		save_credentials(json.result.user)
