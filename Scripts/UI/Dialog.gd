extends Control
var _currentStepIndex = 0
var _steps = []
export var Text = ""
	
func Configure():
	SetDialogText(Text)

func Display():
	get_tree().paused = true
	_setDialogStep(_currentStepIndex)

func _input(event):
	if(event.get_action_strength("ui_select") > 0 && !event.is_echo()):
		_currentStepIndex += 1
		if(_currentStepIndex <= _steps.size() - 1):
			_setDialogStep(_currentStepIndex)
		else:
			get_tree().paused = false
			get_parent().remove_child(self)

func _setDialogStep(stepNumber):
	var dialogChildren = get_children()
	for child in dialogChildren:
		child.queue_free()
	
	add_child(_steps[stepNumber])

func SetDialogText(text : String):
	var charCounter = 0
	var stepString = ""
	if(text.length() > 60):
		for character in text:
			charCounter += 1
			if(charCounter < 60):
				stepString += character
			else:
				CreateDialogStep(stepString)
				stepString = ""
				charCounter = 0
		if(stepString != ""):
			CreateDialogStep(stepString)
	else:
		CreateDialogStep(text)

func CreateDialogStep(text):
	var step = load("res://Scenes/UI/DialogStep.tscn").instance()
	step.SetText(text)
	
	_steps.append(step)
