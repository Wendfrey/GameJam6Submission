extends RefCounted

var filepath:String

func _init(filepath: String):
	self.filepath = filepath
	
func read_file() -> PackedByteArray:
	assert(filepath, "Filepath not set")
	
	if not FileAccess.file_exists(filepath):
		return PackedByteArray()
	
	var fAccess:FileAccess = FileAccess.open(filepath, FileAccess.READ)
	var inputButter: PackedByteArray = fAccess.get_buffer(fAccess.get_length())
	return inputButter

func write_file(input_data: PackedByteArray):
	var fAccess:FileAccess = FileAccess.open(filepath, FileAccess.WRITE)
	fAccess.store_buffer(input_data)
	fAccess.flush()
	
	
