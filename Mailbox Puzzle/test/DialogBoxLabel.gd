extends Label
class_name DialogBoxLabel

var lineno: int = -1
var lines: Array = []
var show_last_line_alone: bool = false
var has_buttons: bool = false


# Function to prepare the Label in DialogBox when a dialog starts
func prepare_label(var lines: Array, var lineno: int, var show_last_line_with_buttons: bool = true,
		var has_buttons: bool = false):
	if lineno >= lines.size():
		return
	
	self.lineno = lineno
	self.lines = lines
	show_last_line_alone = !show_last_line_with_buttons
	self.has_buttons = has_buttons
	text = ""
	visible = true


func clear_label():
	if !visible:
		return
	
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
			print("lineno: ", lineno, " _input")
			
			if lineno == lines.size() and has_buttons and !show_last_line_alone:
				get_parent().show_buttons()
				visible = false
				print("dialog lines completed")
		else:
			clear_label()
			print("dialog lines completed")
			if show_last_line_alone and has_buttons:
				get_parent().show_buttons()
			else:
				get_parent().disable_dialog_box()
