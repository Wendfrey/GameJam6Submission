extends AnimatableBody3D

@onready var animPlayer = $AnimationPlayer
@export var triggerer:Node = null

var open = false :
	set(value):
		if animPlayer and value != open:
			if value:
				animPlayer.play("MoveDown")
			else:
				animPlayer.play("MoveUp")
		open = value

func _ready():
	triggerer.triggered.connect(change_open)

func change_open():
	open = not open
