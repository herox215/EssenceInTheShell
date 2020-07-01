extends RayCast2D

# Der SelectionCast regelt:
# Untersuchen

var _selectedInspection = null

signal OnInspectionSelected(inspectionInteraction)
signal OnInspectionDeselected()

func Clear():
	_selectedInspection = null

func _physics_process(_delta):
	# Es gibt keinen Collider mehr aber wir hatten mal einen.
	# Er muss bereinigt werden_selectedInspection
	if(!is_colliding() && _selectedInspection != null):
		_selectedInspection.Deselect()
		_selectedInspection = null
		emit_signal("OnInspectionDeselected")
	
	if(is_colliding()):
		var collidingObject = get_collider()
		if(collidingObject != null):
			var childsOfObject = collidingObject.get_children()
			var foundInspection = _getInspectionInteraction(childsOfObject)
		
			if(foundInspection != null):
				if(_selectedInspection != null && foundInspection != _selectedInspection):
					_selectedInspection.Deselect()
				
				_selectedInspection = foundInspection
				_selectedInspection.OnSelect()
				emit_signal("OnInspectionSelected", _selectedInspection)
			else: #Wir haben hier jetzt zwar eine Collision, diese ist aber keine InspectionCollision!
				if(_selectedInspection != null):
					_selectedInspection.Deselect()
					_selectedInspection = null
					emit_signal("OnInspectionDeselected")

func _getInspectionInteraction(objects):
	var foundInspection = null
	
	for child in objects:
			if(child.name == "InspectInteraction"):
				foundInspection = child
				break
	
	return foundInspection
