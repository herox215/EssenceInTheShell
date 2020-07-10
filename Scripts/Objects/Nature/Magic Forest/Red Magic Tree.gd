extends Node2D

export var OverrideInspectText = ""
export var OverrideCommandName = ""
export var OverrideCommandContent = ""

func _ready():
	if(OverrideInspectText != ""):
		$StaticBody2D/InteractInteraction.InspectMessage = OverrideInspectText
	if(OverrideCommandName != ""):
		$StaticBody2D/InteractInteraction.CommandName = OverrideCommandName
		$StaticBody2D/InteractInteraction.CommandContent = OverrideCommandContent
		$StaticBody2D/InteractInteraction.ReCreateCommand()
