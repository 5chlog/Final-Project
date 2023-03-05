extends StaticBody2D

onready var dialog_box: DialogBox_re = $"../DialogBox re"

export(Array, Resource) var dialog_resource

var first_interact:bool = true

func _ready():
	pass
	
func interact():
	dialog_box.enable_dialog_box( dialog_resource[0], self, $InteractableArea.player)
	$InteractableArea.active = false

#func sure_button():
#	dialog_box.enable_dialog_box( dialog_resource[1], self, $InteractableArea.player)

func _on_dialogbox_closed():
	dialog_box.disconnect("dialogbox_closed", self, "_on_dialogbox_closed")
	$InteractableArea.active = true
