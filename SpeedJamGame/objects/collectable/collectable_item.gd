extends Node3D

signal player_contact(node)

func _ready():
	if not is_in_group("pickup"):
		add_to_group("pickup")
	
	var last_index = $Mesh.get_child_count()-1
	var dat = randi_range(0, last_index);
	var ext = -1
	#El hexagono mezclado queda feo
	if randf() < 0.25 and dat < last_index:
		var items = range(0, last_index) #Ignorara el hexagono
		items.remove_at(dat)
		ext = items.pick_random()
	
	for i in range($Mesh.get_child_count()):
		$Mesh.get_child(i).visible = (dat == i or ext == i)

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		visible = false
		call_deferred("set_invisible")
		emit_signal("player_contact", self)
		body.pickup_amiation_ready = true
		$Pickupsound.play()
	
func reset():
	$Area3D.monitoring = true
	visible = true
	
func set_invisible():
	$Area3D.monitoring = false
