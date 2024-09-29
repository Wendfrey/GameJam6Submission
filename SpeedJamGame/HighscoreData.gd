extends RefCounted

var max_levels = 5
var max_scores = 5
#2d Array, row is levels, column scores
var savedHighscores: Dictionary = {}

func _init(max_levels = 5, max_scores = 5):
	self.max_levels = max_levels
	self.max_scores = max_scores
	savedHighscores = {}
	
#Save record and return index position of record
# -1 if not a record
func set_record(level:int, newrecord:int) -> int:
	
	var recordIndex = -1
	if not savedHighscores.has(str(level)):
		savedHighscores[str(level)] = [newrecord]
		recordIndex = 0
	else:
		var levelScores:Array = savedHighscores[str(level)].duplicate()
		for lIndex in range(levelScores.size()):
			if newrecord < levelScores[lIndex]:
				recordIndex = lIndex
				break

		if recordIndex == -1 and levelScores.size() < max_scores:
			levelScores.append(newrecord)
			recordIndex = levelScores.size()-1
		elif recordIndex > -1:
			if levelScores.size() < max_scores:
				levelScores += [levelScores[-1]]
			for index in range(levelScores.size()-1, recordIndex, -1):
				levelScores[index] = levelScores[index-1]
			levelScores[recordIndex] = newrecord
		savedHighscores[str(level)] = levelScores
	print("Set result: ", savedHighscores, " - New result: ", newrecord, " - index result: ", recordIndex)
	return recordIndex

func get_records(level:int) -> Dictionary:
	
	var array:Array = savedHighscores.get(str(level))
	if not array: array = []
	
	var output:Dictionary = {}
	for j in range(max_scores):
		if j < array.size():
			output[j+1] = array[j]
		else:
			output[j+1] = 0
		
	return output

func set_data(raw_data: PackedByteArray):
	var dataString = raw_data.get_string_from_utf8()
	print("Data string: ", dataString)
	var result = JSON.parse_string(raw_data.get_string_from_utf8())
	if (result):
		savedHighscores = result
		
	print("Set data: ", savedHighscores)

func convert_data() -> PackedByteArray:
	print("Convert data: ", savedHighscores)
	return JSON.stringify(savedHighscores).to_utf8_buffer()
	

