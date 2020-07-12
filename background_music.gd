extends Node



var timer = null
var rng = null

var sounds = [
	preload("res://assets/sounds/ambiance/misc/synth_2.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_3.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_4.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_5.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_6.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_7.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_8.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_9.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_10.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_11.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_12.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_13.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_14.wav"),
	preload("res://assets/sounds/ambiance/misc/synth_15.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_1.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_2.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_3.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_4.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_5.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_6.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_7.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_8.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_9.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_10.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_11.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_12.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_13.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_14.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_15.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_16.wav"),
	preload("res://assets/sounds/ambiance/misc/equipment_17.wav")
]

var recieve = {
	"a": preload("res://assets/sounds/communication/receive/A_low.wav"),
	"b": preload("res://assets/sounds/communication/receive/B_low.wav"),
	"c": preload("res://assets/sounds/communication/receive/C_low.wav"),
	"D": preload("res://assets/sounds/communication/receive/D_high.wav"),
	"d": preload("res://assets/sounds/communication/receive/D_low.wav"),
	"e": preload("res://assets/sounds/communication/receive/E_low.wav"),
	"f": preload("res://assets/sounds/communication/receive/F_low.wav"),
	"g": preload("res://assets/sounds/communication/receive/G_low.wav")
}

var message_queue = []
var message = []

func _ready():
	$message_stream.connect("finished", self, "_play_message")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	create_new_timer()

func create_new_timer():
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.one_shot = true
	var offset = rng.randi_range(180, 600)
	timer.set_wait_time(offset)
	add_child(timer) #to process
	timer.start() #to start
	
func _on_timer_timeout():
	create_new_timer()
	play_random_sound()

func play_random_sound():
	var i = rng.randi_range(0, len(sounds) -1)
	var sound = sounds[i]
	$random_stream.set_stream(sound)
	$random_stream.play()
	
func add_message(message):
	var msg = []
	for c in message:
		if recieve.has(c):
			var tone = recieve[c]
			msg.append(tone)
	message_queue.append(msg)

func _process(_delta):
	if len(message) == 0 && len(message_queue) > 0:
		message = message_queue.pop_front()
		_play_message()
		
func _play_message():
	if len(message) > 0:
		var tone = message.pop_front()
		$message_stream.set_stream(tone)
		$message_stream.play()
