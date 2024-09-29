extends RefCounted

var filepath:String

func _init(filepath: String):
	self.filepath = filepath
	
func read_file() -> PackedInt64Array:
	assert(filepath, "Filepath not set")
	
	if not FileAccess.file_exists(filepath):
		return PackedInt64Array()
	
	var fAccess:FileAccess = FileAccess.open(filepath, FileAccess.READ)
	var inputButter: PackedByteArray = fAccess.get_buffer(fAccess.get_length())
	fAccess.close()
	return inputButter.to_int64_array()

func write_file(input_data: PackedInt64Array):
	var fAccess:FileAccess = FileAccess.open(filepath, FileAccess.WRITE)
	fAccess.store_buffer(input_data.to_byte_array())
	print(fAccess.get_error())
	fAccess.flush()
	fAccess.close()
	
	
