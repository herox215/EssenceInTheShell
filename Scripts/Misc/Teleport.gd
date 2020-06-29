extends Node2D

export var LevelToTeleportTo = ""
export var xPos = 0
export var yPos = 0
var _playerValidator = null
var _ready = true
signal teleport(command)

# Called when the node enters the scene tree for the first time.
func _ready():
	_playerValidator = load("res://Scripts/Misc/ObjectValidator.gd").new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TeleportArea_body_entered(body):
	# Wenn body ein Player ist, wird teleportiert
	# Ansonsten passiert nichts
	if (_playerValidator.IsPlayer(body) && _ready):
		$TeleportTime.start()
		_ready = false
		print("Player triggert teleport! (Position " + str(body.position) + ")")
		var command = load("res://Scripts/Misc/Command.gd").new("ChangeLevel")
		command.AddValue(LevelToTeleportTo)
		command.AddValue(xPos)
		command.AddValue(yPos)
		emit_signal("teleport", command)
	


func _on_TeleportTime_timeout():
	_ready = true
	$TeleportTime.stop()
