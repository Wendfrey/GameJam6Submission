extends CanvasLayer

@export var focusChild: Control = null

func _ready():
	visibility_changed.connect(_main_child_grab_focus)
	
func _main_child_grab_focus():
	if visible and focusChild:
		focusChild.grab_focus()
