extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8

@export var mouse_sensitivity: float = 0.002
@onready var camera: Camera3D = $Camera3D

var pitch: float = 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, deg_to_rad(-75), deg_to_rad(75))
		camera.rotation.x = pitch
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Vector3.ZERO
	if Input.is_physical_key_pressed(KEY_W):
		direction.z -= 1
	if Input.is_physical_key_pressed(KEY_S):
		direction.z += 1
	if Input.is_physical_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_physical_key_pressed(KEY_D):
		direction.x += 1

	if direction != Vector3.ZERO:
		direction = (transform.basis * Vector3(direction.x, 0, direction.z)).normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.z = move_toward(velocity.z, 0.0, SPEED)

	move_and_slide()
