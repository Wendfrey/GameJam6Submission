extends "res://levels/UIAutoFocus.gd"

signal next_level
signal retry_level

@onready var labelRecords:Array[Label] = [
	$LevelFinished/PanelContainer/VBoxContainer/LabelPosition1,
	$LevelFinished/PanelContainer/VBoxContainer/LabelPosition2,
	$LevelFinished/PanelContainer/VBoxContainer/LabelPosition3,
	$LevelFinished/PanelContainer/VBoxContainer/LabelPosition4,
	$LevelFinished/PanelContainer/VBoxContainer/LabelPosition5
]
@onready var titleLabel:Label = $LevelFinished/PanelContainer/VBoxContainer/TitleLabel
@onready var noPosLabel:Label = $LevelFinished/PanelContainer/VBoxContainer/NoPositionLabel

const text_record = "%d. %02d:%02d %0d"
const text_record_empty = "%d. --:-- --"
const text_record_nope = "X. %02d:%02d %0d"

var tweenShowLabel:Tween

@export var basicColor: Color = Color.WHITE
@export var alertColor: Color = Color.WEB_GREEN

func showData(records: Dictionary, recordIndex:int, time:int):
	for j in range(1,6):
		var recordParsed:Array
		if records.has(j) and records[j] > 0:
			recordParsed = [j] + parseRecord(records[j])
			labelRecords[j-1].text = text_record % recordParsed
		else:
			labelRecords[j-1].text = text_record_empty % [j]
			
	if recordIndex >= 0:
		titleLabel.text =  "NEW RECORD"
		setupTween(labelRecords[recordIndex])
	else:
		titleLabel.text = "HIGHSCORES"
		noPosLabel.visible = true
		noPosLabel.text = text_record_nope % parseRecord(time)

func parseRecord(record:int):
	var minutes:int = record / 60_000
	record = record % 60_000
	var secs:int = record / 1_000
	var milis = record % 1_000
	return [minutes, secs, milis]
	
func _on_retry_button_pressed():
	reset_labels()
	retry_level.emit()


func _on_next_button_pressed():
	reset_labels()
	next_level.emit()

func reset_labels():
	if tweenShowLabel:
		tweenShowLabel.kill()
		
	titleLabel.add_theme_color_override("font_color", basicColor)
	noPosLabel.visible = false
	for label in labelRecords:
		label.add_theme_color_override("font_color", basicColor)

func setupTween(label:Label):
	tweenShowLabel = create_tween()
	tweenShowLabel.set_loops().set_parallel()
	tweenShowLabel.tween_property(label, "theme_override_colors/font_color", alertColor, 1)
	tweenShowLabel.tween_property(titleLabel, "theme_override_colors/font_color", alertColor, 1)
	tweenShowLabel.chain()
	tweenShowLabel.tween_property(label, "theme_override_colors/font_color", basicColor, 1)
	tweenShowLabel.tween_property(titleLabel, "theme_override_colors/font_color", basicColor, 1)
	
