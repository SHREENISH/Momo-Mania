extends CharacterBody3D
#character speed
@export var speed = 14
#downward acceleration
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if Input.is_action_just_pressed("move_left"):
		direction.x -= 1
	
	if Input.is_action_just_pressed("move_back"):
		direction.z += 1
	
	if Input.is_action_just_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
		$Pivot.basis = Basis.looking_at(direction)
		
	#ground velocity
	target_velocity = direction.x * speed
	target_velocity = direction.z * speed
	
	#vertical velocity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		move_and_slide()
