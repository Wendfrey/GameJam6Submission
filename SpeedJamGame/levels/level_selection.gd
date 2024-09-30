extends "res://levels/UIAutoFocus.gd"

signal level_selected(lvl_id)
signal return_main_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	for index in range($Control/GridContainer.get_child_count()):
		var child: Button = $Control/GridContainer.get_child(index)
		child.pressed.connect(emit_signal.bind("level_selected", "lvl"+str(index+1)))
		


func _on_return_button_pressed():
	visible = false
	return_main_menu.emit()
