extends Node2D

var _gameEnvi = null

# Die GameEnvironment wird benötigt, um zwischen Player und Level zu kommunizieren.
# Bsp Teleport.
func SetGameEnvironment(envi):
	_gameEnvi = envi