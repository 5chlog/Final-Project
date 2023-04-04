extends StaticBody2D

# Use Resouces of type DialogResource as elements
export(Array, Resource) var dialog_resources = []


func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_DialogBox_closed")


func interact():
	print("Interacted")
	DialogBox.player = $InteractableArea.player
	DialogBox.enable_dialog_box(dialog_resources[0], self, $InteractableArea.player)
	HUD.get_node("Coins").show()


func button_TL_function():
	print("Next Dialog clicked")
	HUD.get_node("Coins").increase(100)
	DialogBox.enable_dialog_box(dialog_resources[1], self, $InteractableArea.player)


func button_TR_function():
	print("Close Dialog clicked")
	DialogBox.disable_dialog_box()


func _on_DialogBox_closed():
	HUD.get_node("Coins").hide()
