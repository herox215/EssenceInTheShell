extends RayCast2D

# Der InteractionCast regelt:
# Interargieren
# Interagieren kann sein: Sprechen,Schalter aktivieren

var _selectedInteraction = null

signal OnInteractionSelected(interactInteraction)
signal OnInteractionDeselected()

func Clear():
	_selectedInteraction = null
	
func _physics_process(_delta):
	# Es gibt keinen Collider mehr aber wir hatten mal einen.
	# Er muss bereinigt werden_selectedInspection
	if(!is_colliding() && _selectedInteraction != null):
		_selectedInteraction.Deselect()
		_selectedInteraction = null
		emit_signal("OnInteractionDeselected")
		
	if(is_colliding()):
		var collidingObject = get_collider()
		if(collidingObject != null):
			var childsOfObject = collidingObject.get_children()
			var foundInteraction = _getInteractInteraction(childsOfObject)
		
			if(foundInteraction != null && foundInteraction.Command != null):
				if(_selectedInteraction != null && foundInteraction != _selectedInteraction):
					_selectedInteraction.Deselect()
				
				_selectedInteraction = foundInteraction
				_selectedInteraction.OnSelect()
				emit_signal("OnInteractionSelected", _selectedInteraction)
			else: #Wir haben hier jetzt zwar eine Collision, diese ist aber keine InteractionCollision!
				if(_selectedInteraction != null):
					_selectedInteraction.Deselect()
					_selectedInteraction = null
					emit_signal("OnInteractionDeselected")
					
func _getInteractInteraction(objects):
	var foundInteraction = null
	
	for child in objects:
			if(child.name == "InteractInteraction"):
				foundInteraction = child
				break
	
	return foundInteraction
