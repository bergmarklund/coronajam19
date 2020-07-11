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
	preload("res://assets/sounds/ambiance/misc/synth_13.wav")
]

func _ready():
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
