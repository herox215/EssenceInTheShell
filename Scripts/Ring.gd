extends Node2D

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
