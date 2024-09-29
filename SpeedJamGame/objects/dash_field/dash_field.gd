extends Node3D

@onready var area : Area3D = $Area3D
var time: float = 0;

var nodelist: Array[Node] = []

func _ready():
	print("HEY DASH - ready")

func _physics_process(delta):
	if time < 3:
		for n in nodelist:
			n.dash_tile_contact(-global_basis.z)
		if nodelist.size():
			time+=delta;

func accelerate_player(body):
	if body is CharacterBody3D:
		nodelist += [body]
	
func _on_area_3d_body_exited(body):
	var index = nodelist.find(body)
	if index >= 0:
		nodelist.remove_at(index)
	time = 0
