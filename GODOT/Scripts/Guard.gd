extends CharacterBody3D

@export var speed: float = 2.0
@export var wait_time: float = 1.0

var patrol_points: Array[Vector3] = []
var target_index: int = 0
var timer: float = 0.0

func _ready() -> void:
	for child in get_children():
		if child is Marker3D:
			patrol_points.append(child.global_position)

	if patrol_points.size() < 2:
		patrol_points = [global_position, global_position + Vector3(4, 0, 0)]

func _physics_process(delta: float) -> void:
	if patrol_points.is_empty():
		return

	var target_position: Vector3 = patrol_points[target_index]
	var direction = target_position - global_position
	direction.y = 0.0

	if direction.length() < 0.2:
		timer += delta
		if timer >= wait_time:
			timer = 0.0
			target_index = (target_index + 1) % patrol_points.size()
	else:
		timer = 0.0
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

	if is_on_floor() and velocity.y < 0.0:
		velocity.y = 0.0

	move_and_slide()
