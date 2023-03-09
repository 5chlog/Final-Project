extends CanvasLayer

# DialogBox can be enabled by any object with a DialogResouce as member and if
# buttons are used, the functions connected to them as well.
signal dialogbox_closed

var player: Player = null
var caller = null
var enable = false
var disable = false
var dialog_resource = null
onready var label: DialogBoxLabel = $Label
onready var button_1: Button = $Button1
onready var button_2: Button = $Button2
onready var button_3: Button = $Button3
onready var button_4: Button = $Button4
onready var facecontainer = $FaceContainer

func _physics_process(delta):
	if enable:
		enable = false
		_prepare_dialog_box()
	if disable:
		disable = false
		_close_dialog_box()
		player.toggleHold()
		emit_signal("dialogbox_closed")


# Function to show all non-disabled buttons and give focus with the priority order (Highest first)
# - 1, 2, 3, 4
func _show_buttons():
	var focused_button: Button = null
	
	if !button_4.disabled:
		focused_button = button_4
		button_4.visible = true
	if !button_3.disabled:
		focused_button = button_3
		button_3.visible = true
	if !button_2.disabled:
		focused_button = button_2
		button_2.visible = true
	if !button_1.disabled:
		focused_button = button_1
		button_1.visible = true
	
	if focused_button != null:
		focused_button.grab_focus()
		# print("focused on button ", focused_button.text, "? ", focused_button.has_focus())


# Function to initiate a dialog in DialogBox
func enable_dialog_box(var dialog_resource: DialogResource, var caller, var player):
	if dialog_resource.dialogs.size() == 0 and dialog_resource.button_flag == 0:
		return
	if visible and self.dialog_resource != null and self.dialog_resource.button_flag:
		button_1.clear_button()
		button_2.clear_button()
		button_3.clear_button()
		button_4.clear_button()
	self.caller = caller
	self.player = player
	self.dialog_resource = dialog_resource
	enable = true


# Function to prepare the DialogBox and its children when a dialog begin
func _prepare_dialog_box():
	facecontainer.images = dialog_resource.face_images
	facecontainer.names = dialog_resource.names
	button_1.prepare_button(caller, dialog_resource.button_flag, dialog_resource.BUTTON_1_FLAG, 
			dialog_resource.button_tl_text, dialog_resource.button_tl_function)
	button_2.prepare_button(caller, dialog_resource.button_flag, dialog_resource.BUTTON_2_FLAG, 
			dialog_resource.button_bl_text, dialog_resource.button_bl_function)
	button_3.prepare_button(caller, dialog_resource.button_flag, dialog_resource.BUTTON_3_FLAG, 
			dialog_resource.button_tr_text, dialog_resource.button_tr_function)
	button_4.prepare_button(caller, dialog_resource.button_flag, dialog_resource.BUTTON_4_FLAG, 
			dialog_resource.button_br_text, dialog_resource.button_br_function)
	label.prepare_label(dialog_resource.dialogs, dialog_resource.name_face_indices, 
			dialog_resource.show_buttons_with_last_line, dialog_resource.button_flag)
	
	dialog_resource = null
	
	visible = true


# Function to disable the DialogBox
func disable_dialog_box():
	caller = null
	disable = true


# Function to close the DialogBox and its children after a dialog completes
func _close_dialog_box():
	label.clear_label()
	button_1.clear_button()
	button_2.clear_button()
	button_3.clear_button()
	button_4.clear_button()
	facecontainer.visible = false
	
	visible = false
