extends LineEdit

signal CommandCreated(command)

func _on_CommandTextBox_text_entered(new_text):
	var array = new_text.rsplit(" ")
	
	var command = load("res://Scripts/Misc/Command.gd").new(array[0])
	array.remove(array[0])
	
	for argument in array:
		command.AddValue(argument)
		
	emit_signal("CommandCreated", command)
