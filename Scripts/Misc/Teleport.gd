extends Node2D

export var LevelToTeleportTo = ""
export var xPos = 0
export var yPos = 0

signal teleport(lvlName, x, y)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TeleportArea_body_entered(body):
	# Body wird vorerst nicht genutzt.
	emit_signal("teleport", LevelToTeleportTo, xPos, yPos)
