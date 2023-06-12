extends KinematicBody

const MOVE_SPEED = 5
var velocity = Vector3.ZERO
var mouse_sense = 0.05
var jump_force = 18
var gravity = 70
var time_jumped = 0

onready var pivot = $Pivot
onready var camera = $Pivot/Camera

func _ready():
	pass
	
func _physics_process(delta):
	if (is_on_floor()):
		time_jumped = 0
		
	respawn()
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_gravity(delta)
	jump()
	velocity = move_and_slide(velocity, Vector3.UP)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		pivot.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		pivot.rotation.x = clamp(pivot.rotation.x, deg2rad(-89), deg2rad(89))
	
func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	input_vector.z = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	return input_vector.normalized()
	
func apply_movement(input_vector):
	velocity.x = input_vector.x * MOVE_SPEED
	velocity.z = input_vector.z * MOVE_SPEED

func apply_gravity(delta):
	velocity.y -= gravity * delta

func jump():
	if(is_on_floor() and Input.is_action_just_pressed("ui_select")):
		if(time_jumped == 0):
			velocity.y = jump_force
			time_jumped = 1
	
	if not (is_on_floor() and Input.is_action_just_pressed("ui_select")):
		if(time_jumped == 1):
			velocity.y = jump_force
			time_jumped = 2	

func respawn():
	if(Input.is_action_just_pressed("ui_focus_next")):
		get_tree().reload_current_scene()
