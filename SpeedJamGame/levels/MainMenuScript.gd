extends "res://levels/UIAutoFocus.gd"

signal start_game

func _ready():
	super._ready()
	focusChild.grab_focus() #special case because it is main menu

func _on_start_button_pressed():
	emit_signal("start_game")


func _on_quit_button_pressed():
	get_tree().quit()

