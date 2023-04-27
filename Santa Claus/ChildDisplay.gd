extends Node2D

var children = null 
var index:int = 0
var active:bool = false
var running:bool = false


func _ready():
	children = get_node("../Child").get_children()
	get_node("ChildSprite").texture = children[0].get_node("Sprite").texture


func _input(_event):
	if not active or running:
		return
	
	if Input.is_action_just_pressed("game_back"):
		active = false
		$InteractableArea.enable()
		$InteractableArea.player.toggleHold()
	
	if Input.is_action_just_pressed("game_left"):
		index = ( index - 1 + children.size() ) % children.size()
		get_node("ChildSprite").texture = children[index].get_node("Sprite").texture
		
	elif Input.is_action_just_pressed("game_right"):
		index = ( index + 1 ) % children.size()
		get_node("ChildSprite").texture = children[index].get_node("Sprite").texture

func interact():
	active = true
	$InteractableArea.disable()
