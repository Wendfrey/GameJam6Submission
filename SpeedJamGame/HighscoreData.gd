extends RefCounted

var max_levels = 5
var max_scores = 5
#2d Array, row is levels, column scores
var levelRecords: Array = []

func _init(max_levels = 5, max_scores = 5):
	self.max_levels = max_levels
	self.max_scores = max_scores
	
	var inner_array = []
	for j in range(max_scores):
		inner_array.append(0)

	for i in range(max_levels):
		levelRecords.append(inner_array.duplicate())

#Save record and return index position of record
# -1 if not a record
func set_record(level:int, newrecord:int) -> int:
	var index = level-1
	var records:Array = levelRecords[index] as Array
	
	records.sort()
	var new_record_index = -1
	for j in range(records.size()):
		if records[j] < newrecord:
			new_record_index = j
			break
			
	if new_record_index >= 0:
		for j in range(new_record_index, records.size()-1):
			records[j+1] = records[j]
		records[new_record_index] = newrecord
		return new_record_index
		
	return -1

func get_records(level:int) -> Dictionary:
	var index = level-1
	
	var array = levelRecords[index]
	var output:Dictionary = {}
	for j in range(max_scores):
		output[j+1] = array[j]
		
	return output

func set_data(raw_data: PackedInt64Array):
	for lvl in range(max_levels):
		for score in range(max_scores):
			if raw_data.size() <= lvl * max_scores + score:
				break
			levelRecords[lvl][score] = raw_data[lvl * max_scores + score]
			
func convert_data() -> PackedInt64Array:
	var output = PackedInt64Array()

	for lvl in range(max_levels):
		for score in range(max_scores):
			output.append(levelRecords[lvl][score])
	return output


