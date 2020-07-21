extends Control

var _text : String = ""

func SetText(text):
	_text = text
	

func _process(delta):
	$TextLabel.text = _text
	
	
