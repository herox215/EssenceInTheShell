extends Node2D

var _playerValidator = null
var _scale = Vector2.ZERO

func _ready():
	_playerValidator = load("res://Scripts/Misc/ObjectValidator.gd").new()
	_scale = GetRandomVector()
	$GrassSprite.set_scale(_scale)
	
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	if(generator.randf_range(0,2) > 1):
		$GrassSprite.flip_h = true


func _on_Area2D_body_entered(body):
	if(_playerValidator.IsPlayer(body)):
		$GrassSprite.set_scale(Vector2(_scale.x, _scale.y - 0.3))


func _on_Area2D_body_exited(body):
	if(_playerValidator.IsPlayer(body)):
		$GrassSprite.set_scale(Vector2(_scale.x, _scale.y))

func GetRandomVector():
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	
	return Vector2(generator.randf_range(0.7, 1.0), generator.randf_range(0.4, 1.2))
