extends Node2D

var _gameEnvi = null

func SetGameEnvironment(envi):
	_gameEnvi = envi
	
func Open():
	$Objects.add_child(_gameEnvi.CurrentPlayer)

func Close():
	$Objects.remove_child(_gameEnvi.CurrentPlayer)
