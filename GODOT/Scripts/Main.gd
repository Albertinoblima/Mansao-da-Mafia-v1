extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var light: DirectionalLight3D = $DirectionalLight3D

var yaw: float = 0.0
var pitch: float = -0.5
var distance: float = 8.0

func _ready() -> void:
	update_camera_position()
	print("Projeto Mansão da Máfia inicializado.")

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		yaw -= event.relative.x * 0.005
		pitch = clamp(pitch - event.relative.y * 0.005, -1.2, 1.2)
		update_camera_position()

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func update_camera_position() -> void:
	var target = Vector3.ZERO
	var offset = Vector3(
		cos(yaw) * cos(pitch),
		sin(pitch),
		sin(yaw) * cos(pitch)
	) * distance
	camera.position = target + offset
	camera.look_at(target, Vector3.UP)
