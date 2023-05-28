extends KinematicBody

const MOVE_SPEED = 5
var velocity = Vector3.ZERO
var mouse_sense = 0.1
var gravity = 70

onready var pivot = $Pivot
onready var camera = $Pivot/Camera

func _ready():
	pass
	
func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		pivot.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		pivot.rotation.x = clamp(pivot.rotation.x, deg2rad(-89), deg2rad(89))
	
func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()
	
func apply_movement(input_vector):
	velocity.x = input_vector.x * MOVE_SPEED
	velocity.z = input_vector.z * MOVE_SPEED

func apply_gravity(delta):
	velocity.y -= gravity * delta
