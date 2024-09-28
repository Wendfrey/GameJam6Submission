extends Node

func _on_main_menu_start_game():
	for n in $World.get_children():
		n.queue_free()
		
	var lvl1 = load("res://levels/FirstLevel.tscn").instantiate()
	
	$World.add_child(lvl1)
	$MainMenu.visible = false
