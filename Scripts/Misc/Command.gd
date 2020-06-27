extends Node
# Commands "halten" lediglich die Informationen eines Commands.
export var Name = ""
var Values = []

func _init(name):
	Name = name

func AddValue(value):
	Values.push_back(value)
	
func GetValue(index):
	return Values[index]
