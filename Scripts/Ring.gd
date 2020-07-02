extends Node2D

var _interactionDurationPressed = 0
var _interractionPressed = false

var _selectedInteraction = null
var _interacted = false
var Player = null

# Aktualisiert die Position des Rings bzw führt Interaktionen aus.
func _process(delta):
	var mousePosition = get_local_mouse_position()
	rotation += mousePosition.angle()
	
	# Wir verhindern hohe Winkelzahlen.
	if(rotation_degrees > 360):
		rotation_degrees = 0
	if(rotation_degrees < 0):
		rotation_degrees = 360
	
	if(_selectedInteraction != null):
		# Experimental!!
		# Wenn die SelectTaste losgelassen wird bevor die Inspection durchgelaufen ist dann wird die Aktion ausgeführt.
		if(Input.is_action_just_released("ui_interaction") && _interactionDurationPressed < 0.2 && _selectedInteraction.Command != null && !_interacted):
			Player.GUI.SendCommandToGameEnvironment(_selectedInteraction.Command)
			_interactionDurationPressed = 0
			_selectedInteraction = null
		
	_interact(delta)
# Bereinigt die Auswahl.
func Clear():
	$InteractionCast.Clear()
	_selectedInteraction = null

func _interact(delta):
	if(Input.is_action_pressed("ui_interaction")):
		if(_selectedInteraction != null && _selectedInteraction.InspectMessage != null):
			_interactionMode(true)
		else:
			_interacted = false
			_interactionMode(false)
	else:
		_interacted = false
		_interactionMode(false)
	
	if(_interractionPressed && _selectedInteraction.InspectMessage != null):
		_interactionDurationPressed += delta
		
	if(_interactionDurationPressed >= 1 && _selectedInteraction.InspectMessage != null && !_interacted):
		# An dieser Stelle haben wir nun das Objekt untersucht und können den Command ausführen.
		# TODO: Aktuell wird hier nur die Message ausgegeben. Gedacht ist es, dass an dieser Stelle ein Command ausgeführt wird.
		# 		Der "Talk" Command, welcher lediglich eine Textbox mit Text anzeigt. Der Command sollte nur übergeben werden,
		#		gebaut wird er in der "InspectInteraction".
		print(_selectedInteraction.InspectMessage)
		_interactionDurationPressed = 0
		_interacted = true
		

func _interactionMode(enabled):
	if(enabled):
		_interractionPressed = true
		$InteractionRing.show()
		$RingSprite.hide()
	else:
		_interractionPressed = false
		_interactionDurationPressed = 0
		$InteractionRing.hide()
		$RingSprite.show()

func _on_InteractionCast_OnInteractionSelected(interactInteraction):
	_selectedInteraction = interactInteraction


func _on_InteractionCast_OnInteractionDeselected():
	_selectedInteraction = null
