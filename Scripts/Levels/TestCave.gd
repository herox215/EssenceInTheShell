extends Node2D

var _gameEnvi = null

func SetGameEnvironment(envi):
	_gameEnvi = envi

func _ready():
	pass


func _on_Teleport_teleport(command):
	_gameEnvi.ExecuteCommand(command)
