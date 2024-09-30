extends "res://levels/UIAutoFocus.gd"

signal start_game

var FileIO = load("res://FileIO.gd")

func _ready():
	super._ready()
	focusChild.grab_focus() #special case because it is main menu
	$Credits/Panel/Label.text = FileIO.new("res://credits.txt").read_file().get_string_from_utf8()

func _on_start_button_pressed():
	emit_signal("start_game")


func _on_quit_button_pressed():
	get_tree().quit()



func _on_credits_button_pressed():
	$MainMenuHolder.visible = false
	$Credits.visible = true
	$Credits/ReturnCreditsButton.grab_focus()


func _on_return_credits_button_pressed():
	$MainMenuHolder.visible = true
	$Credits.visible = false
	focusChild.grab_focus()
