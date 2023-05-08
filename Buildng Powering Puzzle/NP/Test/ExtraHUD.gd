extends Node2D

onready var animationplayer: AnimationPlayer = get_node("AnimationPlayer")
onready var rooms = get_node("MapBorder/ViewportContainer/Viewport/Map/BuildingSprite/Graph/Rooms")
onready var generators = get_node("MapBorder/ViewportContainer/Viewport/Map/BuildingSprite/Graph/Generators")


func _ready():
	visible = true
	$SelectCount/SelectCountLabel.text = "0/" + String(get_node("/root/Level/GeneratorSwitches").selectable_count)


func show_select_count():
	animationplayer.play("Show Select Count")


func hide_select_count():
	animationplayer.play("Hide Select Count")


func show_map():
	get_node("MapBorder").visible = true
	get_node("InstructionsPanel").visible = true

func hide_map():
	get_node("MapBorder").visible = false
	get_node("InstructionsPanel").visible = false


func get_rooms():
	return rooms


func get_generators():
	return generators
	
