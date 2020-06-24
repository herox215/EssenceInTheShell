extends KinematicBody2D

var _velocity = Vector2.ZERO

export var Friction = 350
export var MaxSpeed = 100
export var Acceleration = 600

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	inputVector = inputVector.normalized()
	
	if(inputVector != Vector2.ZERO):
		_velocity = _velocity.move_toward(inputVector * MaxSpeed, Acceleration * delta)
	else:
		_velocity = _velocity.move_toward(Vector2.ZERO, Friction * delta)
	
	move_and_slide(_velocity)


func _process(delta):
	if(Input.get_action_strength("ui_select") == 1):
		print($Ring.GetAngle())
