extends Node2D

var _playerValidator = null

func _ready():
	_playerValidator = load("res://Scripts/Misc/ObjectValidator.gd").new()


func _on_Area2D_body_entered(body):
	if(_playerValidator.IsPlayer(body)):
		$GrassSprite.set_scale(Vector2(1,0.3))


func _on_Area2D_body_exited(body):
	if(_playerValidator.IsPlayer(body)):
		$GrassSprite.set_scale(Vector2(1,1))
