extends Node2D

var _gameEnvi = null

func SetGameEnvironment(envi):
	_gameEnvi = envi

func _on_Teleport_teleport(command):
	_gameEnvi.ExecuteCommand(command)
	
func Open():
	$Objects.add_child(_gameEnvi.GetPlayer())

func Close():
	$Objects.remove_child(_gameEnvi.GetPlayer())
