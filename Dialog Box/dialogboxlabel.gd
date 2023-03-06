extends Label
class_name DialogBoxLabel

var lineno: int = -1
var lines: Array = []
var show_last_line_alone: bool = false
var has_buttons: bool = false
var dialog_completed = true


# Function to prepare the Label in DialogBox when a dialog starts
func prepare_label(var lines: Array, var show_last_line_with_buttons: bool = true,
		var has_buttons: bool = false):
	if lines.size() == 0:
		clear_label()
		if has_buttons:
			dialog_completed = true
			# print("dialog completed")
			get_parent()._show_buttons()
		return
	
	dialog_completed = false
	self.lines = lines
	show_last_line_alone = !show_last_line_with_buttons
	self.has_buttons = has_buttons
	text = lines[0]
	lineno = 1
	visible = true
	grab_focus()
	if self.lineno == lines.size() and has_buttons and show_last_line_with_buttons:
		dialog_completed = true
		# print("dialog completed")
		get_parent()._show_buttons()


func clear_label():
	if !visible:
		return
	
	dialog_completed = true
	self.lineno = -1
	self.lines = []
	show_last_line_alone = false
	self.has_buttons = false
	text = ""
	visible = false


func _physics_process(delta):
	if visible and Input.is_action_just_pressed("ui_accept"):
		if lineno < lines.size():
			text = lines[lineno]
			lineno += 1
			
			# If last line and has buttons to show alone with the line
			if lineno == lines.size() and has_buttons and !show_last_line_alone:
				get_parent()._show_buttons()
				dialog_completed = true
				# print("dialog lines completed")
		elif !dialog_completed:
			dialog_completed = true
			# print("dialog lines completed")
			text = ""
			if show_last_line_alone and has_buttons:
				get_parent()._show_buttons()
			else:
				get_parent().disable_dialog_box()
