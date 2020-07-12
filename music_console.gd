extends Spatial
signal exit_msg_console
signal send_button_clicked(play_sequence)
signal done_playing_sequence

var led = preload("res://led.tscn")
var button = preload("res://music_button.tscn")
var led_nodes = []
var buttons = []
var player_tones = {}
var play_sequence = []
var console_locked = false
var exit_on_finish = false

var number_of_leds = 5
var led_music_state = 0
var time = 0
var timer = null
var delay_between_tones_in_second = 1.5

# Colors
var red = Color(1,0,0)
var hover_yellow = Color(1,1,0)
var green = Color(0.11,0.38,0.11, 0.8)
var yellow = Color(1,1,0, 0.8)

var tone_sequence = []
var string_of_tones = "cbagfed"
var signals = { 
	"c" : preload("res://assets/sounds/communication/send/C_medium.wav"),
	"b" : preload("res://assets/sounds/communication/send/B_medium.wav"),
	"a" : preload("res://assets/sounds/communication/send/A_medium.wav"),
	"g" : preload("res://assets/sounds/communication/send/G_medium.wav"),
	"f" : preload("res://assets/sounds/communication/send/F_medium.wav"),
	"e" : preload("res://assets/sounds/communication/send/E_medium.wav"),
	"d" : preload("res://assets/sounds/communication/send/D_medium.wav")
	}

func _input(event):
	if console_locked:
		return
	if event is InputEventMouseButton:	
		if(event.pressed && event.button_index == BUTTON_RIGHT):
			emit_signal("exit_msg_console")
			
# Called when the node enters the scene tree for the first time.
func _ready():
	render_leds()
	clear_leds()
	init_signals()
	init_play_and_send_button()
	self.connect("done_playing_sequence", self, "_on_done_playing_sequence")

func init_signals():
	timer = Timer.new()
	self.add_child(timer)
	timer.set_wait_time(delay_between_tones_in_second)
	var tones = $SendSignals.get_children()
	var i = 0
	for tone in tones:
		player_tones[string_of_tones[i]] = tone
		i += 1
	
func init_play_and_send_button():
	var play_button = $play_button
	var send_button = $send_button
	play_button.connect("music_button_clicked", self, "_on_play_button_clicked")
	send_button.connect("music_button_clicked", self, "_on_send_button_clicked")
		
func _on_send_button_clicked(_id):
	if console_locked:
		return
	var tones = map_digit_to_tones(play_sequence)
	emit_signal("send_button_clicked", tones)
	console_locked = true
	exit_on_finish = true
	play_tones()
	
func _on_done_playing_sequence():
	if exit_on_finish:
		emit_signal("exit_msg_console")
	console_locked = false

func map_digit_to_tones(play_sequence):
	var tone_sequence = ""
	for id in play_sequence:
		tone_sequence += string_of_tones[id]
	return tone_sequence

func _on_play_button_clicked(_id):
	if !console_locked:
		console_locked = true
		play_tones()
		
func play_tones():
	if len(tone_sequence) > 0:
		return
	tone_sequence = map_digit_to_tones(play_sequence)
	var i = 0
	for tone in tone_sequence:
		led_nodes[i][play_sequence[i]].activate_navigation_led()
		player_tones[tone].stream = signals[tone]
		player_tones[tone].play()
		timer.start()
		yield(timer, "timeout")
		i += 1
	tone_sequence = []
	for j in range(i):
		led_nodes[j][play_sequence[j]].disable_navigation_led()
	emit_signal("done_playing_sequence")
	
func render_leds():
	var origin_pos_led = $LED.transform.origin
	var origin_pos_button = $music_choice_button.transform.origin
	for i in range(number_of_leds):
		render_button(i, origin_pos_button)
		var led_array = []
		for j in range(number_of_leds):
			var led = render_led(i, j, origin_pos_led)
			led_array.append(led)
		led_nodes.append(led_array)

func render_button(id, origin_pos):
	var posistion = Vector3(origin_pos.x, 0, origin_pos.z + id * 4)
	var button_node = button.instance()
	button_node.connect("music_button_clicked", self, "_on_music_button_clicked")
	button_node.id = id
	button_node.set_translation(posistion)
	buttons.append(button_node)
	self.add_child(button_node)
	
func _on_music_button_clicked(id):
	if !console_locked:
		if led_music_state % 5 == 0:
			clear_leds()
		var node_to_active = 1
		play_sequence.append(id)
		led_nodes[(led_music_state % 5)][id].change_led_color(green, 10)
		led_music_state += 1
	
func render_led(x_pos, z_pos, origin_pos):
	var posistion = Vector3(origin_pos.x + x_pos * 6, 0.25, origin_pos.z + z_pos * 4)
	var led_scale = Vector3(3,3,3)
	var led_node = led.instance()
	led_node.set_translation(posistion)
	led_node.set_scale(led_scale)
	self.add_child(led_node)
	return led_node

func clear_leds():
	play_sequence = []
	for i in range(5):
		for j in range(5):
			led_nodes[i][j].change_led_color(green)
