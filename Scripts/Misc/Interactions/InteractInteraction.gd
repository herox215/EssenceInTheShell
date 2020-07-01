extends Node2D
export var CommandName: String
export var CommandContent: String

var Command = null

func _ready():
	ReCreateCommand()
	$InteractionSprite.hide()
	
func OnSelect():
	if(Command != null):
		$InteractionSprite.show()
	
func Deselect():
	$InteractionSprite.hide()
	
func ReCreateCommand():
	if(CommandName != ""):
		Command = load("res://Scripts/Misc/Command.gd").new(CommandName)
		var commandParameters = CommandContent.split(" ")
		for param in commandParameters:
			Command.AddValue(param)
