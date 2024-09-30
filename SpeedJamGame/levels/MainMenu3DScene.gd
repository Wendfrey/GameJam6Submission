extends Node3D

func _ready():
	$AnimationPlayer.play("mainMenu")
	$spaceship/AnimationPlayer.play("idle")
