extends Resource
class_name DialogResource

const BUTTON_1_FLAG = 1
const BUTTON_2_FLAG = 4
const BUTTON_3_FLAG = 2
const BUTTON_4_FLAG = 8

export(Array, Texture) var face_images = []
export(Array, String) var names = []
export(Array, String, MULTILINE) var dialogs = []
export(Array, int) var name_face_indices = []
export(int, FLAGS, "Button TL", "Button TR", "Button BL", "Button BR") var button_flag = 0
export(String) var button_tl_text = "Option 1"
export(String) var button_tl_function = "button_TL_function" # Name of function in caller npc to be 
		# connected to button 1
export(String) var button_tr_text = "Option 3"
export(String) var button_tr_function = "button_TR_function" # Name of function in caller npc to be
		# connected to button 3
export(String) var button_bl_text = "Option 2"
export(String) var button_bl_function = "button_BL_function" # Name of function in caller npc to be
		# connected to button 2
export(String) var button_br_text = "Option 4"
export(String) var button_br_function = "button_BR_function" # Name of function in caller npc to be
		# connected to button 4
export(bool) var show_buttons_with_last_line = true # If true, will display the last line of dialog
		# along with the buttons. If false, will display the buttons after clearing the last line.
