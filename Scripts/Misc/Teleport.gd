extends Node2D

export var LevelToTeleportTo = ""
export var xPos = 0
export var yPos = 0

signal teleport(command)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TeleportArea_body_entered(body):
	var command = load("res://Scripts/Misc/Command.gd").new("ChangeLevel")
	command.AddValue(LevelToTeleportTo)
	command.AddValue(xPos)
	command.AddValue(yPos)
	
	# Body wird vorerst nicht genutzt.
	emit_signal("teleport", command)
