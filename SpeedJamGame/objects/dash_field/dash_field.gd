extends Node3D

@onready var area : Area3D = $Area3D

var nodelist: Array[Node] = []

func _ready():
	print("HEY DASH - ready")

func _physics_process(delta):
	for n in nodelist:
		n.dash_tile_contact(-global_basis.z)

func accelerate_player(body):
	nodelist += [body]
	
func _on_area_3d_body_exited(body):
	var index = nodelist.find(body)
	if index >= 0:
		nodelist.remove_at(index)
