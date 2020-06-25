extends Control


func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/MenuOptions/continue.grab_focus()
#	$Background. = OS.get_real_window_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rect_size = OS.get_real_window_size()
	if($MarginContainer/CenterContainer/VBoxContainer/MenuOptions/continue.is_hovered() == true):
		$MarginContainer/CenterContainer/VBoxContainer/MenuOptions/continue.grab_focus()
	if($MarginContainer/CenterContainer/VBoxContainer/MenuOptions/options.is_hovered() == true):
		$MarginContainer/CenterContainer/VBoxContainer/MenuOptions/options.grab_focus()
	if($MarginContainer/CenterContainer/VBoxContainer/MenuOptions/end.is_hovered() == true):
		$MarginContainer/CenterContainer/VBoxContainer/MenuOptions/end.grab_focus()


func _on_continue_pressed():
	get_tree().change_scene("res://Scenes/Essence.tscn")


func _on_end_pressed():
	get_tree().quit()
