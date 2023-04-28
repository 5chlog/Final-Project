extends Node2D


var active: bool = false
var running: bool = false
var index: int = 0
var parts_list = null
var machine_count = 0
var machine_dismantled = []

onready var prev_object = get_node("ObjectDisplay/Objects/PreviousObject")
onready var cur_object = get_node("ObjectDisplay/Objects/CurrentObject")
onready var next_object = get_node("ObjectDisplay/Objects/NextObject")

# Called when the node enters the scene tree for the first time.
func _ready():
	parts_list = Certificates.parts_list
	machine_count = parts_list.size()
	machine_dismantled.resize(machine_count)
	machine_dismantled.fill(false)
	
	if machine_count > 0:
		$PartsDisplay.set_parts(parts_list[0])
	else:
		get_node("ObjectDisplay/Objects").visible = false
		return
	
	set_object_number_from_index(get_node("ObjectDisplay/Objects/PreviousObject"), machine_count - 1)
	set_object_number_from_index(get_node("ObjectDisplay/Objects/CurrentObject"), 0)
	set_object_number_from_index(get_node("ObjectDisplay/Objects/NextObject"), 1)


func interact():
	active = true
	$InteractableArea.disable()


func _input(_event):
	if not active or running:
		return
	
	if Input.is_action_just_pressed("game_back"):
		active = false
		$InteractableArea.enable()
		$InteractableArea.player.toggleHold()
	elif Input.is_action_just_pressed("game_left") and machine_count > 1:
		$AnimationPlayer.play("Move Display Right")
		running = true
	elif Input.is_action_just_pressed("game_right") and machine_count > 1:
		$AnimationPlayer.play("Move Display Left")
		running = true
	elif Input.is_action_just_pressed("ui_accept") and machine_count > 0:
		pass


func set_object_number_from_index(var object, var index: int):
	object.get_node("UpperDigit").frame = (index + 1) / 10
	object.get_node("LowerDigit").frame = (index + 1) % 10


func set_object_number_from_object(var object, var source_object):
	object.get_node("UpperDigit").frame = source_object.get_node("UpperDigit").frame
	object.get_node("LowerDigit").frame = source_object.get_node("LowerDigit").frame


func update_on_move(direction):
	if direction == "Left":
		index = (index + 1) % machine_count
		$PartsDisplay.set_parts(parts_list[index])
		
		set_object_number_from_object(prev_object, cur_object)
		set_object_number_from_object(cur_object, next_object)
		
	elif direction == "Right":
		index = (index - 1 + machine_count) % machine_count
		$PartsDisplay.set_parts(parts_list[index])
		
		set_object_number_from_object(next_object, cur_object)
		set_object_number_from_object(cur_object, prev_object)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Move Display Left":
		running = false
		get_node("ObjectDisplay/Objects").position.x = 0
		
		var next_index = (index + 1) % machine_count
		set_object_number_from_index(next_object, next_index)
	elif anim_name == "Move Display Right":
		running = false
		get_node("ObjectDisplay/Objects").position.x = 0
		
		var prev_index = (index - 1 + machine_count) % machine_count
		set_object_number_from_index(prev_object, prev_index)
		
