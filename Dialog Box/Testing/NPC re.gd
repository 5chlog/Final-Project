extends StaticBody2D

# Use Resouces of type DialogResource as elements
export(Array, Resource) var dialog_resources = []

func interact():
	print("Interacted")
	DialogBox.player = $InteractableArea.player
	DialogBox.enable_dialog_box(dialog_resources[0], self, $InteractableArea.player)


func button_TL_function():
	print("Next Dialog clicked")
	DialogBox.enable_dialog_box(dialog_resources[1], self, $InteractableArea.player)


func button_TR_function():
	print("Close Dialog clicked")
	DialogBox.disable_dialog_box()
