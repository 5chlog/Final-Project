extends StaticBody2D

export(Array, Resource) var dialog_resource

var first_interact:bool = true

func _ready():
	pass
	
func interact():
	DialogBox.enable_dialog_box( dialog_resource[0], self, $InteractableArea.player)
	$InteractableArea.active = false

#func sure_button():
#	dialog_box.enable_dialog_box( dialog_resource[1], self, $InteractableArea.player)
