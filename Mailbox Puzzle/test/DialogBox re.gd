extends CanvasLayer
class_name DialogBox_re

var player: Player = null
var caller = null
export(Resource) var dialog_resource = null
onready var label: DialogBoxLabel = $Label
onready var button_1: Button = $Button1
onready var button_2: Button = $Button2
onready var button_3: Button = $Button3
onready var button_4: Button = $Button4
onready var option_arrow_1 = $OptionArrow1
onready var option_arrow_2 = $OptionArrow2
onready var option_arrow_3 = $OptionArrow3
onready var option_arrow_4 = $OptionArrow4

# Function to prepare the DialogBox and its children when a dialog begin
func prepare_dialog_box(var dialog_resource: DialogResource, var caller):
	self.caller = caller
	self.dialog_resource = dialog_resource
	
	label.prepare_label(dialog_resource.dialogs, 0)
	if dialog_resource.button_flag & dialog_resource.BUTTON_1_FLAG: # Preparing Button 1
		button_1.prepare_button(dialog_resource.button_flag, dialog_resource.BUTTON_1_FLAG, 
				dialog_resource.button_1_text, dialog_resource.button_1_function)
	if dialog_resource.button_flag & dialog_resource.BUTTON_2_FLAG: # Preparing Button 2
		button_2.prepare_button(dialog_resource.button_flag, dialog_resource.BUTTON_2_FLAG, 
				dialog_resource.button_2_text, dialog_resource.button_2_function)
	if dialog_resource.button_flag & dialog_resource.BUTTON_3_FLAG: # Preparing Button 3
		button_3.prepare_button(dialog_resource.button_flag, dialog_resource.BUTTON_3_FLAG, 
				dialog_resource.button_3_text, dialog_resource.button_3_function)
	if dialog_resource.button_flag & dialog_resource.BUTTON_4_FLAG: # Preparing Button 4
		button_4.prepare_button(dialog_resource.button_flag, dialog_resource.BUTTON_4_FLAG, 
				dialog_resource.button_4_text, dialog_resource.button_4_function)
	
	if dialog_resource.dialogs.size() > 0: # If there is text in the dialog_resource
		label.grab_focus()
	elif dialog_resource.button_flag: # If there is not text but there are button in the dialog_resource
		label.prepare_label([], 0)
		if button_1.visible:
			option_arrow_1.visible = true
			button_1.grab_focus()
		elif button_2.visible:
			option_arrow_2.visible = true
			button_2.grab_focus()
		elif button_3.visible:
			option_arrow_3.visible = true
			button_3.grab_focus()
		elif button_4.visible:
			option_arrow_4.visible = true
			button_4.grab_focus()
	else:
		return
	visible = true


func close_dialog_box():
	pass
