extends LineEdit

signal CommandCreated(command)
var _commands = []
var _counter = 0

func _on_CommandTextBox_text_entered(new_text):
	# Wenn der eingegebene Text nicht leer ist
	# _commands neuen array-eintrag von eingegebenem Text hinzufuegen
	if(new_text != ""):
		_commands.append(new_text)
		
	var array = new_text.rsplit(" ")
	
	var command = load("res://Scripts/Misc/Command.gd").new(array[0])
	array.remove(array[0])
	
	for argument in array:
		command.AddValue(argument)
		
	_counter = 0
	emit_signal("CommandCreated", command)

func _input(event):
# mit einem counter werden die eingegebenen commands gezählt und können mit den Pfeiltasten durch den counter wieder aufgerufen werden 
	if(event.get_action_strength("ui_page_down") && !event.is_echo()):
		if(_counter > 0):
			# Text setzen auf den Inhalt vom Index (Size von _commands - _counter) von _commands
			set_text(_commands[_commands.size() - _counter])
			_counter = _counter - 1 # _counter danach runter zählen
		if(_counter == 0):
			set_text("") # Wenn _counter 0 ist dann soll der Text leer sein 
	if(event.get_action_strength("ui_page_up") && !event.is_echo()):
		if(_counter < _commands.size()):
			_counter = _counter + 1 # _counter hochzählen
			# Text setzen auf den Inhalt vom Index (Size von _commands - _counter) von _commands
			set_text(_commands[_commands.size() - _counter])	
