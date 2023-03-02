extends Button
class_name DialogBoxButton

var caller = null
var function_name: String = ""

func prepare_button(var caller, var button_flag: int, 	var button_filter: int, 
		var button_text: String, var button_function: String):
	if button_flag & button_filter: # Preparing Button 1
		text = button_text
		self.caller = caller
		function_name = button_function
		connect("pressed", caller, button_function)
		visible = true
	else:
		text = ""
		function_name = ""
		caller = null


func clear_button(var button):
	text = ""
	disconnect("pressed", caller, function_name)
	function_name = ""
	caller = null
	visible = false
