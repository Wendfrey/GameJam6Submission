extends Node3D


func _on_area_3d_body_entered(body):
	print("Player entered")
	queue_free()
