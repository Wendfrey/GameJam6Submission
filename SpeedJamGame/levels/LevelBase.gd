extends Node3D

signal level_finished(lvl_code)

@export var door:Node3D
@export var level_name:String = "lvl0"
var listNodes:Array[Node] = []

func _ready():
	var templistNodes = get_tree().get_nodes_in_group("pickup")
	
	listNodes = templistNodes.filter(func(n): return is_ancestor_of(n))
	
	for n in listNodes:
		n.connect("player_contact", player_collected_pickup)
		
	door.player_reached_end.connect(_on_door_player_reached_end)
	
func player_collected_pickup(node:Node3D):
	var openDoor = true
	for n in listNodes:
		if n.visible:
			openDoor = false
			break
	
	if openDoor:
		door.play_anim()

func _on_door_player_reached_end():
	emit_signal("level_finished", level_name)
