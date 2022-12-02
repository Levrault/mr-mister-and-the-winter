extends State

@export var max_speed_default := 2.0
@export var friction_default := 10.0
@export var angular_acceleration := 7.0


var input_direction := Vector2.ZERO
var friction := friction_default
var max_speed := max_speed_default


static func calculate_velocity(
	direction: Vector3,
	current_max_speed: float,
	old_velocity: Vector3,
	gravity: int,
	current_friction: float,
	delta: float,
) -> Vector3:
	var velocity = old_velocity
	var hvel = Vector3.ZERO
	velocity.y -= delta * gravity
	hvel = velocity

	direction.y = 0
	direction = direction.normalized()

	var target = direction
	target *= current_max_speed
	hvel = hvel.lerp(target, current_friction * delta)
	
	if hvel.length() < current_max_speed * 0.01:
		hvel = Vector3.ZERO
	
	velocity.x = hvel.x
	velocity.z = hvel.z

	return velocity


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", { impulse = true })
		return


func physics_process(delta: float) -> void:
	if not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")

	input_direction = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction: Vector3 = (owner.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	
	owner.velocity = calculate_velocity(
		direction,
		max_speed,
		owner.velocity,
		owner.gravity,
		friction,
		delta
	)
	lerp_rotation_to_direction(direction, delta)
	owner.move_and_slide()


func lerp_rotation_to_direction(direction: Vector3, delta: float) -> void:
	if not (Input.is_action_pressed("move_forwards") or Input.is_action_pressed("move_backwards") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")): 
		return
	owner.model.rotation.y = lerp_angle(owner.model.rotation.y, atan2(direction.x, direction.z),  delta * angular_acceleration)
