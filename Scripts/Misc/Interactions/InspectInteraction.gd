extends Node2D

export var InspectMessage = ""

func _ready():
	$QuestionSprite.hide()
	
func OnSelect():
	$QuestionSprite.show()
	
func Deselect():
	$QuestionSprite.hide()
