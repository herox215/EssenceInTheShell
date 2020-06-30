extends Node2D

var _selectedInspectionInteraction = null
var Player = null

# Updates the ringposition.
func _process(_delta):
	var mousePosition = get_local_mouse_position()
	rotation += mousePosition.angle()
	
	# Wir verhindern hohe Winkelzahlen.
	if(rotation_degrees > 360):
		rotation_degrees = 0
	if(rotation_degrees < 0):
		rotation_degrees = 360

# Returns the angle of the current ringposition.
func GetAngle():
	return rotation_degrees

func Clear():
	$SelectionCast.Clear()
	_selectedInspectionInteraction = null

func _input(event):
	if(event.get_action_strength("ui_interaction")):
		if(_selectedInspectionInteraction != null):
			print(_selectedInspectionInteraction.InspectMessage)

func _on_SelectionCast_OnInspectionDeselected():
	_selectedInspectionInteraction = null


func _on_SelectionCast_OnInspectionSelected(inspectionInteraction):
	_selectedInspectionInteraction = inspectionInteraction
