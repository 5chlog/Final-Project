extends Sprite

onready var animation = $AnimationPlayer
export(Array, Resource) var dialogs
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogBox.connect("dialogbox_closed", self, "_next_dialog")
	pass # Replace with function body.


func interact():
	DialogBox.enable_dialog_box(dialogs[0], self, $InteractableArea.player)
	pass


func _process(delta):
	animation.play("Idle")

func _next_dialog(dialog_name):
	get_node("../Door").open_door()
	DialogBox.disconnect("dialogbox_closed", self, "_next_dialog")
