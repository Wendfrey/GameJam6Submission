extends AnimatableBody3D

@onready var animPlayer = $AnimationPlayer
@export var triggerer:Node = null

func _ready():
	triggerer.triggered.connect(func(): open = not open)
	
var open = false :
	set(value):
		if value and animPlayer:
			animPlayer.play("MoveDown")
		else:
			animPlayer.play("MoveUp")
		open = value
