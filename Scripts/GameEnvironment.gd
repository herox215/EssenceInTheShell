extends Node2D

var CurrentPlayer = null

func _ready():
	CurrentPlayer = _createPlayer(_createGui())
	ChangeLevel("TestRealm")

func _createGui():
	var gui = load("res://Scenes/GUI/GUI.tscn").instance()
	gui.SetGameEnvironment(self)
	return gui;

# Erstellt einen neuen Spieler, optional mit Kamera.
func _createPlayer(gui):
	var newPlayer = load("res://Scenes/Misc/Player.tscn").instance()
	add_child(gui)
	newPlayer.GUI = gui
	return newPlayer

# Ändert das aktuelle Level.
# Optional kann die Position mit angegeben werden.
func ChangeLevel(lvlName, posX = 0, posY= 0):
	if(lvlName != "" && lvlName != null && lvlName.to_lower() != $CurrentLevel.name.to_lower()):
		CurrentPlayer.GUI.WriteOutput("ChangeLevel started...")
		if($CurrentLevel.get_child_count() > 0):
			# Aktuell wird einfach immer das Level komplett entfernt mitsamt allen Objekten, Positionen usw.
			# Hier muss Logik zum Speichern geschrieben werden, damit beim erneuten Betreten nicht wieder alles neu geladen wird.
			CurrentPlayer.GUI.WriteOutput("Need to clear level cache")
			var childLevel = $CurrentLevel.get_child(0)
			$CurrentLevel.get_child(0).Close()
			$CurrentLevel.get_child(0).queue_free()
		
		# Darf später NUR gemacht werden wenn es noch kein Level im Cache gibt.
		# Ansonsten Cache benutzen.
		var LvlToChange = load("res://Scenes/Levels/"+lvlName+".tscn")
		var lvlToChange = LvlToChange.instance()
		
		lvlToChange.SetGameEnvironment(self)
		lvlToChange.Open()
		
		# Wenn man versucht direkt "add_child" aufzurufen kommt es zu massig Fehlen in der Konsole.
		# Mit Call_Deferred lässt man erst alle Multitreading Prozesse durchlaufen und am Ende fügt man es hinzu.
		$CurrentLevel.call_deferred("add_child", lvlToChange)
		
		CurrentPlayer.GUI.WriteOutput("Level added.")

	if(int(posX) > 0 || int(posY) > 0):
		# Aktuell wird immer davon ausgegangen, dass eine Essence existiert. Das muss auf jeden Fall dynamischer werden.
		CurrentPlayer.SetPosition(posX,posY)

func ExecuteCommand(command):
	command.Name = command.Name.to_lower()
	CurrentPlayer.GUI.WriteOutput("Command will be executed: " + command.Name)
	# Wir wollen ein Level ändern
	if(command.Name == "changelevel" || command.Name == "cl" || command.Name == "tp"):
		ChangeLevel(command.GetValue(0), command.GetValue(1), command.GetValue(2))
		CurrentPlayer.GUI.WriteOutput("Level changed to " + command.GetValue(0))
		
	if(command.Name == "coordinates" || command.Name == "cor"):
		CurrentPlayer.GUI.WriteOutput(CurrentPlayer.position)
		
	if(command.Name == "changeposition"):
		ChangeLevel("", command.GetValue(0), command.GetValue(1))
