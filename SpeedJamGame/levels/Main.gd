extends Node

@onready var fadeinoutBackground:ColorRect = $CanvasLayer/Transition/FadeInOutTransition

func _on_game_load():
	$MainMenu.visible = false
	get_tree().paused = false

func _on_main_menu_start_game():
	$MainMenu.visible = false
	_on_level_finished("main_menu")

func _on_level_finished(lvl_name):
	$CanvasLayer/Control/TimerLabel.stopTimer()
	get_tree().paused = true
	match (lvl_name):
		"main_menu":
			transition("res://levels/level_1.tscn", on_load_level_finish)
		"lvl1":
			transition("res://levels/level_2.tscn", on_load_level_finish)
		"lvl2":
			transition("res://levels/level_3.tscn", on_load_level_finish)
		_:
			transition("res://levels/main_menu_scene.tscn", func(): $MainMenu.visible = true)
			print("NO MATCH")
			
func load_scene(scene:Node3D):
	$World.add_child(scene)
	for n in $World.get_children():
		if not n == scene:
			n.queue_free()
	if (scene.has_signal("level_finished")):
		scene.level_finished.connect(_on_level_finished)

func transition(resourcePath: String, on_finish_tween: Callable = func():pass):
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
		get_tree().paused = false
		on_finish_tween.call()
	)

func on_load_level_finish():
	$CanvasLayer/Control/TimerLabel.startTimer()
