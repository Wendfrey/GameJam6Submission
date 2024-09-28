extends CharacterBody3D

enum MoveType {
	ALWAYS_FORWARD,
	INERTIA_DRAG
}

@export var ACCELERATION: float = 1
@export var MAX_SPEED:float = 5.0 : 
	set(value):
		MAX_SPEED = value
		MAX_SPEED_SQ = pow(value, 2)
@export var DEACCELERATION:float = 0.5
@export_range(0.01, 2*PI) var rotation_speed:float = PI
@export var movementType: MoveType = MoveType.ALWAYS_FORWARD 


@onready var modelAnim = $ModelHolder/spaceship/AnimationPlayer
@onready var modelHolder = $ModelHolder
@onready var brakingSound = $BrakingSound
@onready var MAX_SPEED_SQ = pow(MAX_SPEED, 2)
var current_speed:float = 0
var extraspeed_ring: float = 0
var movement_func: Callable = mode_move_always_forward
var enable_movement: bool = true


func _ready():
	if (movementType == MoveType.ALWAYS_FORWARD):
		movement_func = mode_move_always_forward
	else:
		movement_func = mode_drag_forces
		
	$ModelHolder/spaceship/AnimationPlayer.play("idle")

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
		
	var rotate_direction = Input.get_axis("rotate_left", "rotate_right")
	
	rotate_y(- rotation_speed * rotate_direction * delta * (1 + current_speed/MAX_SPEED))
	if enable_movement:
		movement_func.call()
	var collision:KinematicCollision3D = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()).limit_length(5)

var bracking_tween: Tween
func _unhandled_input(event):
	if event.is_action_pressed("move_bracker") and not bracking_tween:
		var temp_velocity = velocity.normalized()
		var vectorRotation = Vector3(-PI/32, 0, 0)
		brakingSound.play()
		bracking_tween = create_tween()
		bracking_tween.tween_property(self, "enable_movement", false, 0)
		bracking_tween.set_parallel()
		bracking_tween.tween_property(self, "velocity", temp_velocity, 0.1)
		bracking_tween.tween_property(modelHolder, "rotation", vectorRotation, 0.25).from(Vector3.ZERO)
		bracking_tween.set_parallel(false)
		bracking_tween.tween_interval(0.4)
		bracking_tween.tween_property(self, "velocity", Vector3.ZERO, 0)
		bracking_tween.tween_property(modelHolder, "rotation", Vector3.ZERO, 0.15).from(vectorRotation)
		bracking_tween.tween_property(self, "enable_movement", true, 0)
		bracking_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		bracking_tween.finished.connect(func ():
			bracking_tween = null
		)

func mode_drag_forces():
	if Input.is_action_pressed("move_accel"):
		velocity += - basis.z * ACCELERATION
		if velocity.length_squared() > MAX_SPEED_SQ:
			velocity = velocity.limit_length(MAX_SPEED)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, DEACCELERATION)

func mode_move_always_forward():
	if Input.is_action_pressed("move_accel"):
		current_speed = move_toward(current_speed, MAX_SPEED, ACCELERATION)
		
		if velocity.length_squared() > MAX_SPEED_SQ:
			velocity = velocity.limit_length(MAX_SPEED)
	else:
		current_speed = move_toward(current_speed, 0, DEACCELERATION)
		if modelAnim.current_animation != "idle":
			modelAnim.play("idle")
	if not is_zero_approx(current_speed):
		velocity = -basis.z * current_speed
		
func ring_interaction():
	extraspeed_ring = 2
