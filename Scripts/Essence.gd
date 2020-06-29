extends KinematicBody2D

var _velocity = Vector2.ZERO
var _currentSpeed = 0

export var Friction = 1000
export var MaxSpeed = 100
export var Acceleration = 1000
export var SprintSpeed = 30
export var Name = ""

var GUI = null

func _ready():
	_currentSpeed = MaxSpeed

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	if(!GUI.IsDebug()):
		inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	inputVector = inputVector.normalized()
	 
	if(inputVector != Vector2.ZERO):
		_velocity = _velocity.move_toward(inputVector * _currentSpeed, Acceleration * delta)
		
	else:
		_velocity = _velocity.move_toward(Vector2.ZERO, Friction * delta)
	
	move_and_slide(_velocity)
	global_position = global_position.round()


func _process(_delta):
	if(Input.get_action_strength("ui_select") == 1):
		print($Ring.GetAngle())
	if(Input.get_action_strength("ui_sprint") > 0):
		_currentSpeed = MaxSpeed + SprintSpeed
	else:
		_currentSpeed = MaxSpeed
	
func SetPosition(x,y):
	position = Vector2(x,y)

