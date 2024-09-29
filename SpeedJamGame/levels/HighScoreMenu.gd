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

const text_record = "%d. %02d:%02d %03d"

func showData(records: Dictionary):
	for j in range(1,6):
		var recordParsed:Array
		if not records.has(j):
			recordParsed = [j,0,0,0]
		else:
			recordParsed = [j] + parseRecord(records[j])
		labelRecords[j-1].text = text_record % recordParsed

func parseRecord(record:int):
	var minutes:int = record / 60_000
	record = record % 60_000
	var secs:int = record / 1_000
	var milis = record % 1_000
	return [minutes, secs, milis]
