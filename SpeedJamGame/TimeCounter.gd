extends Label

var timeStart:int

func _ready():
	set_process(false)

func startTimer():
	timeStart = Time.get_ticks_msec()
	visible = true
	set_process(true)
	
func _process(delta):
	_update_text()
	
func _update_text():
	var diffTime:int = Time.get_ticks_msec() - timeStart
	var minutes:int = diffTime / 60_000
	diffTime = diffTime % 60_000
	var secs:int = diffTime / 1_000
	diffTime = diffTime % 1_000
	var updated_text = "%02d:%02d %03d" % [minutes, secs, diffTime]
	text = updated_text
	
func stopTimer():
	visible = false
	set_process(false)
	return Time.get_ticks_msec() - timeStart
