extends Node2D

var _interactionDurationPressed = 0
var _interractionPressed = false

var _selectedInspectionInteraction = null
var Player = null

# Updates the ringposition.
func _process(delta):
	var mousePosition = get_local_mouse_position()
	rotation += mousePosition.angle()
	
	# Wir verhindern hohe Winkelzahlen.
	if(rotation_degrees > 360):
		rotation_degrees = 0
	if(rotation_degrees < 0):
		rotation_degrees = 360
	
	_interact(delta)
	
# Returns the angle of the current ringposition.
func GetAngle():
	return rotation_degrees

func Clear():
	$SelectionCast.Clear()
	_selectedInspectionInteraction = null

func _interact(delta):
	if(Input.is_action_pressed("ui_interaction")):
		_interractionPressed = true
		if(_selectedInspectionInteraction != null):
			$InteractionRing.show()
			$RingSprite.hide()
		else:
			_interactionDurationPressed = 0
			$InteractionRing.hide()
			$RingSprite.show()
	else:
		_interractionPressed = false
		_interactionDurationPressed = 0
		$InteractionRing.hide()
		$RingSprite.show()
	
	if(_interractionPressed && _selectedInspectionInteraction != null):
		_interactionDurationPressed += delta
		
	if(_interactionDurationPressed >= 1 && _selectedInspectionInteraction != null):
		print(_selectedInspectionInteraction.InspectMessage)
		_interactionDurationPressed = 0

func _on_SelectionCast_OnInspectionDeselected():
	_selectedInspectionInteraction = null

func _on_SelectionCast_OnInspectionSelected(inspectionInteraction):
	_selectedInspectionInteraction = inspectionInteraction
