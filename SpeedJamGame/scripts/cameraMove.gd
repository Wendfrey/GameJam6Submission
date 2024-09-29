extends Camera3D

@export var player: Node3D;
@export var rotateHor: bool = false;
@export var moveVertUp: bool = false;
@export var moveVertDown: bool = false;
@export var rotateSpeed: float = 0.005;
@export var rotateLimit: float = 0.18;
@export var rotateTrigger: float = 25;
@export var moveVertUpTrigger: float = -15;
@export var moveVertDownTrigger: float = 0;
@export var moveVertUpLimit: float = -500;
@export var moveVertDownLimit: float = 500;


var initialVert:float;

# Called when the node enters the scene tree for the first time.
func _ready():
	initialVert = self.position.z;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rotateHor:
		var newRot = self.rotation.y;
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
		self.rotation.y = newRot;
		
	if moveVertUp or moveVertDown:
		print("----------")
		print(player.position.z)
		print(moveVertUpTrigger)
		var newVert = self.position.z;
		if moveVertUp and player.position.z < moveVertUpTrigger:
			newVert = player.position.z-moveVertUpTrigger;
			print(newVert)
			if newVert < moveVertUpLimit:
				newVert = moveVertUpLimit;
			newVert+=initialVert;
			print(newVert)
		elif moveVertDown and player.position.z > moveVertDownTrigger:
			newVert = player.position.z-moveVertDownTrigger;
			if newVert > moveVertDownLimit:
				newVert = moveVertDownLimit;
			newVert+=initialVert;
		elif newVert != initialVert:
			newVert = initialVert;
		self.position.z = newVert;
	pass
