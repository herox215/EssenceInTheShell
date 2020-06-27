extends Node2D

var _gameEnvi = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SetGameEnvironment(envi):
	_gameEnvi = envi

func _on_Teleport_teleport(command):
	_gameEnvi.ExecuteCommand(command)
