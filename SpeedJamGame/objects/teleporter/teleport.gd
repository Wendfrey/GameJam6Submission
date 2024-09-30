extends Area3D

var disableUntilLeaves = false;

@export var Destiny: Node3D;


func _on_body_exited(body):
	#disableUntilLeaves = false
	pass # Replace with function body.

func _on_body_entered(body):
	if body is CharacterBody3D:
		if not disableUntilLeaves:
			$TeleportSound.play()
			Destiny._disable_tp()
			body.global_position.x = Destiny.global_position.x;
			body.global_position.z = Destiny.global_position.z;
			(body as CharacterBody3D)
		else:
			disableUntilLeaves = false
		
	pass # Replace with function body.

func _disable_tp():
	disableUntilLeaves = true
