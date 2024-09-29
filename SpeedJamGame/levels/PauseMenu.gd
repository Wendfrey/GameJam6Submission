extends "res://levels/UIAutoFocus.gd"

signal level_restart
signal return_menu
signal open_options

func _on_continue_button_pressed():
	visible = false
	get_tree().paused = false


func _on_restart_button_pressed():
	visible = false
	level_restart.emit()


func _on_return_menu_pressed():
	visible = false
	return_menu.emit()


func _on_options_button_pressed():
	open_options.emit()
