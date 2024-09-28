extends Node3D
@onready var animPlayer:AnimationPlayer = $AnimationPlayer

func play_anim():
	animPlayer.play("OpenDoor")
	$Area3D.monitoring = true
	
func reset_anim():
	animPlayer.play("Reset")
	$Area3D.monitoring = false


func _on_area_3d_body_entered(body):
	print("LEVEL_FINISHED")
