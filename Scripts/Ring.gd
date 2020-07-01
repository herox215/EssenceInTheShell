extends Node2D

var _interactionDurationPressed = 0
var _interractionPressed = false

var _selectedInspectionInteraction = null
var _selectedInteractInteraction = null

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
	
	# Experimental!!
	# Wenn die SelectTaste losgelassen wird bevor die Inspection durchgelaufen ist dann wird die Aktion ausgeführt.
	if(Input.is_action_just_released("ui_interaction") && _interactionDurationPressed < 1 && _selectedInteractInteraction != null):
		Player.GUI.SendCommandToGameEnvironment(_selectedInteractInteraction.Command)
		_interactionDurationPressed = 0
	
	_interact(delta)

# Bereinigt die Auswahl.
func Clear():
	$SelectionCast.Clear()
	$InteractionCast.Clear()
	_selectedInspectionInteraction = null

func _interact(delta):
	if(Input.is_action_pressed("ui_interaction")):
		if(_selectedInspectionInteraction != null):
			_interactionMode(true)
		else:
			_interactionMode(false)
	else:
		
		_interactionMode(false)
	
	if(_interractionPressed && _selectedInspectionInteraction != null):
		_interactionDurationPressed += delta
		
	if(_interactionDurationPressed >= 1 && _selectedInspectionInteraction != null):
		# An dieser Stelle haben wir nun das Objekt untersucht und können den Command ausführen.
		# TODO: Aktuell wird hier nur die Message ausgegeben. Gedacht ist es, dass an dieser Stelle ein Command ausgeführt wird.
		# 		Der "Talk" Command, welcher lediglich eine Textbox mit Text anzeigt. Der Command sollte nur übergeben werden,
		#		gebaut wird er in der "InspectInteraction".
		print(_selectedInspectionInteraction.InspectMessage)
		_interactionDurationPressed = 0

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

func _on_SelectionCast_OnInspectionDeselected():
	_selectedInspectionInteraction = null

func _on_SelectionCast_OnInspectionSelected(inspectionInteraction):
	_selectedInspectionInteraction = inspectionInteraction


func _on_InteractionCast_OnInteractionSelected(interactInteraction):
	_selectedInteractInteraction = interactInteraction


func _on_InteractionCast_OnInteractionDeselected():
	_selectedInteractInteraction = null
