extends Camera3D

@export var player: Node3D;
@export var rotateHor: bool = false;
@export var moveVert: bool = false;
@export var moveSpeed: float = 1.5;
@export var rotateSpeed: float = 0.005;
@export var rotateLimit: float = 0.18;
@export var rotateTrigger: float = 25;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if rotateHor:
		var newRot = self.rotation.y;
		print("-------------")
		print(newRot)
		if player.position.x > rotateTrigger:
			newRot = newRot-rotateSpeed;
			if(newRot<-rotateLimit): newRot = -rotateLimit;
		elif player.position.x < -rotateTrigger:
			newRot = newRot+rotateSpeed;
			if(newRot>rotateLimit): newRot = rotateLimit;
		elif newRot > 0:
			newRot = newRot-rotateSpeed;
			if(newRot<0): newRot = 0;
		elif newRot < 0:
			newRot = newRot+rotateSpeed;
			if(newRot>0): newRot = 0;
		print(newRot)
		self.rotation.y = newRot;
	pass
