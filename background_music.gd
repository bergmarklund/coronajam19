extends Node

var timer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	create_new_timer()

func create_new_timer():
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	timer.one_shot = true
	timer.set_wait_time(10)
	add_child(timer) #to process
	timer.start() #to start
	
func _on_timer_timeout():
	print("timeout")
	create_new_timer()
