extends Node3D

@export var door:Node3D
var listNodes:Array[Node] = []

func _ready():
	listNodes = get_tree().get_nodes_in_group("pickup")
	for n in listNodes:
		n.connect("player_contact", player_collected_pickup)
	
func player_collected_pickup(node:Node3D):
	var finish = true
	for n in listNodes:
		if n.visible:
			finish = false
			break
	
	if finish:
		door.play_anim()
