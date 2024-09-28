extends Area3D

signal triggered

@onready var bodyMesh:MeshInstance3D = $Body
@export var colorBase: Color = Color("ff0015")
@export var colorActive: Color = Color("ff4c41")
@export var only_once: bool = true

var is_triggered:bool = false

func _on_body_entered(body):
	bodyMesh.material_override.albedo_color = colorActive
	if not (not is_triggered or not only_once):
		triggered.emit()
		is_triggered = true

func _on_body_exited(body):
	if not only_once:
		bodyMesh.material_override.albedo_color = colorBase
	
