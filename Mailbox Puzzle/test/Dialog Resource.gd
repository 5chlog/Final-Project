extends Resource
class_name DialogResource

const BUTTON_1_FLAG = 1
const BUTTON_2_FLAG = 2
const BUTTON_3_FLAG = 4
const BUTTON_4_FLAG = 8

export(Array, String, MULTILINE) var dialogs = [""]
export(int, FLAGS, "Button 1", "Button 2", "Button 3", "Button 4") var button_flag = 0
export(String) var button_1_text = "Option 1"
export(String) var button_1_function = "button1_function" # Name of function in caller npc to be bound to button 1
export(String) var button_2_text = "Option 2"
export(String) var button_2_function = "button2_function" # Name of function in caller npc to be bound to button 2
export(String) var button_3_text = "Option 3"
export(String) var button_3_function = "button3_function" # Name of function in caller npc to be bound to button 3
export(String) var button_4_text = "Option 4"
export(String) var button_4_function = "button4_function" # Name of function in caller npc to be bound to button 4
