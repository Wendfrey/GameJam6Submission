extends Node3D

@onready var model = $spaceship
@onready var anim = $spaceship/AnimationPlayer


func _ready():
	anim.get_animation("idle").loop_mode = Animation.LOOP_LINEAR
	anim.play("idle")
	$AnimationPlayer.play("mainMenu")
