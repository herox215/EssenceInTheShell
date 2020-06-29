extends Node2D

var _debugMode = false
var _gameEnvi = ""

func IsDebug():
	return _debugMode

func SetGameEnvironment(envi):
	_gameEnvi = envi

func WriteOutput(text):
	$TextOutputBox.text = $TextOutputBox.text + "\n" + str(text)

func _process(delta):
	if(_debugMode):
		$CommandTextBox.show()
		$CommandTextBox.grab_focus()
	else:
		$CommandTextBox.text = ""
		$CommandTextBox.hide()

func _input(event):
	if(event.get_action_strength("ui_debug") > 0 && !event.is_echo()):
		_debugMode = !_debugMode

func _on_CommandTextBox_CommandCreated(command):
	_debugMode = false
	_gameEnvi.ExecuteCommand(command)
