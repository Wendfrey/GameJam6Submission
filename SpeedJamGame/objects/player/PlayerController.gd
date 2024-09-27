extends CharacterBody3D


const SPEED = 5.0
const PIHALH = PI/2
@export var ACCELERATION: float = 1
@export var MAX_SPEED:float = 5.0
@export var DEACCELERATION:float = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var cameraRotator = $CameraRotator
@onready var model = $ModelHolder
@onready var camera = $CameraRotator/Camera3D

var extraspeed_ring: float = 0


func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	transform.basis = transform.basis.rotated(transform.basis.x, move_direction.y * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, -move_direction.x * delta)
		
	model.rotation.z = lerp(model.rotation.z, -move_direction.x * PI/8, 20 * delta)
		
	var rotate_direction = Input.get_vector("rotate_left", "rotate_right", "rotate_up", "rotate_down")
	
	calculate_speed()
	#cameraRotator.rotate_y(-rotate_direction.x * delta)
	#cameraRotator.rotate(cameraRotator.basis.x, rotate_direction.y * delta)

	move_and_slide()
	
func ring_interaction():
	extraspeed_ring = 2
	if (fovTween):
		fovTween.kill()
	fovTween = null
	
var fovTween:Tween
func calculate_speed():
	if (extraspeed_ring > 0):
		extraspeed_ring -= get_physics_process_delta_time()
		velocity = - basis.z * MAX_SPEED * 1.5
		if not fovTween:
			fovTween = create_tween()
			fovTween.tween_property(camera, "fov", 110, 0.1).from(90).set_ease(Tween.EASE_IN_OUT)
			fovTween.tween_interval(1)
			fovTween.tween_property(camera, "fov", 90, 0.2).from(110).set_ease(Tween.EASE_IN_OUT)
	else:
		velocity = lerp(velocity, - basis.z * MAX_SPEED, ACCELERATION)
