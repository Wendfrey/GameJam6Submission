extends Node3D

signal player_contact(node)

func _ready():
	if not is_in_group("pickup"):
		add_to_group("pickup")
	var dat = randi_range(0,$Mesh.get_child_count()-1);
	var ext = randi_range(0,$Mesh.get_child_count());
	
	for mesh in $Mesh.get_children():
		mesh.visible = dat==0 || ext==0;
		dat-=1; ext-=1;

func _on_area_3d_body_entered(body):
	visible = false
	call_deferred("set_invisible")
	emit_signal("player_contact", self)
	body.pickup_amiation_ready = true
	
func reset():
	$Area3D.monitoring = true
	visible = true
	
func set_invisible():
	$Area3D.monitoring = false
