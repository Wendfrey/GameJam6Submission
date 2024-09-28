extends Node

func _ready():
	var firstLevel:Node3D = load("res://levels/TestWorld.tscn").instantiate()
	$World.add_child(firstLevel)
	$CanvasLayer/Control/TimerLabel.startTimer()
	
