extends "res://levels/UIAutoFocus.gd"

signal level_restart
signal return_menu

func _on_continue_button_pressed():
	visible = false
	get_tree().paused = false


func _on_restart_button_pressed():
	visible = false
	level_restart.emit()


func _on_return_menu_pressed():
	visible = false
	return_menu.emit()
