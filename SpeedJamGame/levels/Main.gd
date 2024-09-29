extends Node

@onready var fadeinoutBackground:ColorRect = $TransitionLayer/Transition/FadeInOutTransition
@export var saveFilepath = "user://highscore.dat"
var fileStorage
var recordData
var current_lvl

func _ready():
	fileStorage = load("res://HighscoreRecorder.gd").new(saveFilepath)
	recordData = load("res://HighscoreData.gd").new(3, 5)
	recordData.set_data(fileStorage.read_file())
	
	$MainMenu.visible = true
	current_lvl = "main_menu"
	load_scene(load("res://levels/main_menu_scene.tscn").instantiate())
	
func _on_game_load():
	$MainMenu.visible = false
	get_tree().paused = false

func _on_main_menu_start_game():
	$MainMenu.visible = false
	goto_lvl1()

func _on_level_finished(lvl_name):
	get_tree().paused = true
	
	var lvl = 0
	match current_lvl:
		"lvl1": lvl = 1
		"lvl2": lvl = 2
		"lvl3": lvl = 3
	if lvl > 0:
		var timeTotal:int = stopTimer()
		recordData.set_record(lvl, timeTotal)
		fileStorage.write_file(recordData.convert_data())
		var level_records = recordData.get_records(lvl)
		$HighScoreLayer.visible = true
		$HighScoreLayer.showData(level_records)
	#_on_next_level()

func load_scene(scene:Node3D):
	$World.add_child(scene)
	for n in $World.get_children():
		if not n == scene:
			n.queue_free()
	if (scene.has_signal("level_finished")):
		scene.level_finished.connect(_on_level_finished)

func goto_main_menu():
	current_lvl = "main_menu"
	transition("res://levels/main_menu_scene.tscn", func(): 
		if get_tree().paused:
			get_tree().paused = false
		$MainMenu.visible = true
		)
	
func goto_lvl1():
	current_lvl = "lvl1"
	transition("res://levels/level_1.tscn", on_level_loaded)
	
func goto_lvl2():
	current_lvl = "lvl2"
	transition("res://levels/level_2.tscn", on_level_loaded)
	
func goto_lvl3():
	current_lvl = "lvl3"
	transition("res://levels/level_3.tscn", on_level_loaded)

func on_level_loaded():
	$CounterLayer.visible = true
	startTimer()

func transition(resourcePath: String, on_finish_tween: Callable = func():pass):
	$TransitionLayer.visible = true
	var transitionTween = create_tween()
	transitionTween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fadeinoutBackground.visible = true
	transitionTween.tween_property(fadeinoutBackground, "color", Color.BLACK, 0.5).from(Color(0, 0, 0, 0))
	transitionTween.tween_callback(func ():
		var instance = load(resourcePath).instantiate()
		load_scene(instance)
	)
	transitionTween.tween_property(fadeinoutBackground, "color", Color(0, 0, 0, 0), 0.5).from(Color.BLACK)
	transitionTween.tween_interval(0.1)
	transitionTween.tween_callback(func():
		$TransitionLayer.visible = false
		get_tree().paused = false
		on_finish_tween.call()
	)

func stopTimer() -> int:
	$CounterLayer.visible = false
	return $CounterLayer/Control/TimerLabel.stopTimer()

func startTimer() -> void:
	$CounterLayer/Control/TimerLabel.startTimer()

func _on_next_level():
	$HighScoreLayer.visible = false
	match (current_lvl):
		"lvl1": goto_lvl2()
		"lvl2": goto_lvl3()
		"lvl3": goto_main_menu()
		_: print("NO MATCH")

func _on_retry_level():
	$HighScoreLayer.visible = false
	match (current_lvl):
		"lvl1": goto_lvl1()
		"lvl2": goto_lvl2()
		"lvl3": goto_lvl3()
		_: print("NO MATCH")


func _on_pause_menu_level_restart():
	stopTimer()
	_on_retry_level()


func _on_pause_menu_return_menu():
	stopTimer()
	goto_main_menu()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and current_lvl != "main_menu":
		get_tree().paused = not get_tree().paused
		$PauseLayer.visible = get_tree().paused
