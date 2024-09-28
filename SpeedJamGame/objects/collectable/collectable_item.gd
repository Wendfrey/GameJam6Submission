extends Node3D

signal player_contact(node)

func _ready():
	if not is_in_group("pickup"):
		add_to_group("pickup")

func _on_area_3d_body_entered(body):
	visible = false
	call_deferred("set_invisible")
	emit_signal("player_contact", self)
	
func reset():
	$Area3D.monitoring = true
	visible = true
	
func set_invisible():
	$Area3D.monitoring = false
