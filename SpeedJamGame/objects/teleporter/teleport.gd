extends Area3D

var disableUntilLeaves = false;

@export var Destiny: Node3D;


func _on_body_exited(body):
	disableUntilLeaves = false
	pass # Replace with function body.

func _on_body_entered(body):
	if not disableUntilLeaves:
		Destiny.disableUntilLeaves = true;
		body.position.x = Destiny.position.x;
		body.position.z = Destiny.position.z;
	pass # Replace with function body.
