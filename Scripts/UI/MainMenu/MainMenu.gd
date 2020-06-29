extends Control

func _ready():
	self.rect_size = OS.get_real_window_size()

# Startet das Spiel
func _on_continue_pressed():
	get_tree().change_scene("res://Scenes/GameEnvironment.tscn")

# Beendet das Spiel
func _on_end_pressed():
	get_tree().quit()
