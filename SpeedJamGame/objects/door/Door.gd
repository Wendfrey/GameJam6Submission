extends Node3D
@onready var animPlayer:AnimationPlayer = $AnimationPlayer

signal player_reached_end

func play_anim():
	animPlayer.play("OpenDoor")
	$Area3D.monitoring = true
	
func reset_anim():
	animPlayer.play("Reset")
	$Area3D.monitoring = false


func _on_area_3d_body_entered(body):
	emit_signal("player_reached_end")
	body.velocity = Vector3.ZERO
