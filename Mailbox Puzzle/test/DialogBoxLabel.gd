extends Label
class_name DialogBoxLabel

var lineno: int = -1
var lines: Array = []

# Function to prepare the Label in DialogBox when a dialog starts
func prepare_label(var lines: Array, var lineno: int):
	self.lineno = lineno
	self.lines = lines
	visible = true
	if lineno < lines.size():
		text = lines[lineno]
		lineno += 1


func clear_label():
	pass


func _input(event):
	if visible and Input.is_action_just_pressed("ui_accept"):
		if lineno < lines.size():
			text = lines[lineno]
			lineno += 1
		else:
			pass
		
