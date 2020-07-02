extends Node2D

# Text, wenn das Objekt untersucht wird.
export var InspectMessage : String

# Stellt den Command da, welcher ausgeführt wird.
export var CommandName: String
export var CommandContent: String

var _inspected = false

# Auszuführender Command.
var Command = null

func _ready():
	ReCreateCommand()
	$InteractionSprite.hide()
	
func OnSelect():
	if(Command != null):
		$InteractionSprite.show()
	
func Deselect():
	$InteractionSprite.hide()
	_inspected = false
	
func ReCreateCommand():
	if(CommandName != ""):
		Command = load("res://Scripts/Misc/Command.gd").new(CommandName)
		var commandParameters = CommandContent.split(" ")
		for param in commandParameters:
			Command.AddValue(param)

func SetInspected():
	_inspected = true
	
func IsInspected():
	return _inspected
