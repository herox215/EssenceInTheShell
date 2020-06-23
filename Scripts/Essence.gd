extends KinematicBody2D

var VELOCITY = Vector2.ZERO
const FRICTION = 350
const MAXSPEED = 100
const ACCELERATION = 600

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	inputVector = inputVector.normalized()
	
	if(inputVector != Vector2.ZERO):
		VELOCITY = VELOCITY.move_toward(inputVector*MAXSPEED, ACCELERATION * delta)
	else:
		VELOCITY = VELOCITY.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide(VELOCITY)


func _process(delta):
	if(Input.get_action_strength("ui_select") == 1):
		print($Ring.GetAngle())
