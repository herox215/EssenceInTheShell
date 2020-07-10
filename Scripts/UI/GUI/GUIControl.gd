extends Node2D

var _debugMode = false
var _gameEnvi = ""

func IsDebug():
	return _debugMode

func SetGameEnvironment(envi):
	_gameEnvi = envi

func WriteOutput(text):
	# Zeitstempel hinzufügen
	var formattedText = "[" + str(OS.get_time().hour) + ":" + str(OS.get_time().minute) +"] : " + str(text)
	$Control/TextOutputBox.text = $Control/TextOutputBox.text + "\n"
	# Ausgabe
	$Control/TextOutputBox.text += formattedText
	print(formattedText)

func SendCommandToGameEnvironment(command):
	_gameEnvi.ExecuteCommand(command)

func _process(delta):
	if(_debugMode):
		$Control/CommandTextBox.show()
		$Control/TextOutputBox.show()
		$Control/CommandTextBox.grab_focus()
	else:
		$Control/CommandTextBox.text = ""
		$Control/CommandTextBox.hide()
		$Control/TextOutputBox.hide()

func _input(event):
	if(event.get_action_strength("ui_debug") > 0 && !event.is_echo()):
		_debugMode = !_debugMode

func _on_CommandTextBox_CommandCreated(command):
	_debugMode = false
	_gameEnvi.ExecuteCommand(command)
