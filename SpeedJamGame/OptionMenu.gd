extends "res://levels/UIAutoFocus.gd"

signal exit_options

@onready var masterSlider = $Control/HBoxContainer/SliderContainers/MasterSlider
@onready var musicSlider = $Control/HBoxContainer/SliderContainers/MusicSlider
@onready var audioSlider = $Control/HBoxContainer/SliderContainers/AudioSlider

const busLayer:AudioBusLayout = preload("res://audio_bus_layout.tres")

var masterID = AudioServer.get_bus_index("Master") : 
	set(value): pass
var musicID = AudioServer.get_bus_index("Music") : 
	set(value): pass
var audioID = AudioServer.get_bus_index("Audio") : 
	set(value): pass
	
	
func _ready():
	super._ready()
	masterSlider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(masterID)))
	musicSlider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(musicID)))
	audioSlider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(audioID)))
	visibility_changed.connect(_on_visibility_change)
	

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(masterID, linear_to_db(value))


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(musicID, linear_to_db(value))


func _on_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(audioID, linear_to_db(value))


func _on_audio_slider_drag_ended(value_changed):
	$AudioPlayer.play()

func _on_confirm_button_pressed():
	visible = false
	emit_signal("exit_options")
	
func _on_visibility_change():
	if visible:
		masterSlider.editable = true
		musicSlider.editable = true
		audioSlider.editable = true
	else:
		masterSlider.editable = false
		musicSlider.editable = false
		audioSlider.editable = false
		($AudioPlayer as AudioStreamPlayer).stop()
		
