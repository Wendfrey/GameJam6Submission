extends CharacterBody3D


const SPEED = 5.0
const PIHALH = PI/2
@export var ACCELERATION: float = 1
@export var MAX_SPEED:float = 5.0 : 
	set(value):
		MAX_SPEED = value
		MAX_SPEED_SQ = pow(value, 2)
@export var DEACCELERATION:float = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var model = $ModelHolder
@onready var MAX_SPEED_SQ = pow(MAX_SPEED, 2)
var current_speed:float = 0

var extraspeed_ring: float = 0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
		
	var rotate_direction = Input.get_axis("rotate_left", "rotate_right")
	var accelerate = 1 if Input.is_action_pressed("move_accel") else 0
	
	rotate_y(rotate_direction * delta * (1 + current_speed/MAX_SPEED))
	if accelerate > 0:
		current_speed = move_toward(current_speed, MAX_SPEED, ACCELERATION)
		
		if velocity.length_squared() > MAX_SPEED_SQ:
			velocity = velocity.normalized() * MAX_SPEED
	else:
		current_speed = move_toward(current_speed, 0, DEACCELERATION)
	if not is_zero_approx(current_speed):
		velocity = -basis.z * current_speed

	move_and_slide()
	
func ring_interaction():
	extraspeed_ring = 2
