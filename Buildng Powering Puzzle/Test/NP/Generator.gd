tool

extends AnimatedSprite
class_name GeneratorVertex


export(int) var id_number = 0
var on: bool = false
var room_list: Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	animation = "Off"
	frame = 0
	playing = false
	
	$FirstDigitSprite.frame = int(id_number/10) % 10 
	$SecondDigitSprite.frame = id_number % 10


func switch_on():
	if on:
		return
	
	play("On")
	on = true
	
	for room in room_list:
		room.switch_on(self)


func switch_off():
	if not on:
		return
	
	animation = "Off"
	frame = 0
	playing = false
	on = false
	
	for room in room_list:
		room.switch_off(self)
