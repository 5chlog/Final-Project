extends Button
class_name DialogBoxButton

var caller = null
var function_name: String = ""

func prepare_button(var caller, var button_flag: int, var button_filter: int, 
		var button_text: String, var button_function: String):
	# If Button is selected in Button Flag
	if button_flag & button_filter:
		text = button_text
		self.caller = caller
		function_name = button_function
		connect("pressed", caller, button_function)
		disabled = false
	else:
		clear_button()


func clear_button():
	if disabled:
		return
	
	text = ""
	if caller != null and is_connected("pressed", caller, function_name):
		disconnect("pressed", caller, function_name)
	function_name = ""
	caller = null
	visible = false
	disabled = true


func _on_Button_focus_entered():
	get_child(0).visible = true # Child is the TextureRect with Arrow to button


func _on_Button_focus_exited():
	get_child(0).visible = false # Child is the TextureRect with Arrow to button
