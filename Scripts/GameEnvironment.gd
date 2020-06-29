extends Node2D

var CurrentPlayer = null
var _gui = null

func _ready():
	_gui = _createGui()
	CurrentPlayer = _createPlayer(_gui)
	ChangeLevel("TestRealm")

func _createGui():
	var gui = load("res://Scenes/GUI/GUI.tscn").instance()
	gui.SetGameEnvironment(self)
	return gui;

# Erstellt einen neuen Spieler, optional mit Kamera.
func _createPlayer(gui):
	var newPlayer = load("res://Scenes/Essence.tscn").instance()
	newPlayer.add_child(gui)
	return newPlayer

# Ändert das aktuelle Level.
# Optional kann die Position mit angegeben werden.
func ChangeLevel(lvlName, posX = 0, posY= 0):
	if(lvlName != "" && lvlName != null && lvlName.to_lower() != $CurrentLevel.name.to_lower()):
		print("ChangeLevel started...")
		if($CurrentLevel.get_child_count() > 0):
			# Aktuell wird einfach immer das Level komplett entfernt mitsamt allen Objekten, Positionen usw.
			# Hier muss Logik zum Speichern geschrieben werden, damit beim erneuten Betreten nicht wieder alles neu geladen wird.
			print("Need to clear level cache")
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
		
		print("Level added.")

	if(int(posX) > 0 || int(posY) > 0):
		# Aktuell wird immer davon ausgegangen, dass eine Essence existiert. Das muss auf jeden Fall dynamischer werden.
		CurrentPlayer.SetPosition(posX,posY)
	
	
		
func ExecuteCommand(command):
	print("Command will be executed: " + command.Name)
	# Wir wollen ein Level ändern
	if(command.Name.to_lower() == "changelevel" || command.Name.to_lower() == "cl" || command.Name.to_lower() == "tp"):
		ChangeLevel(command.GetValue(0), command.GetValue(1), command.GetValue(2))
		_gui.WriteOutput("Level changed to " + command.GetValue(0))
		
	if(command.Name.to_lower() == "coordinates" || command.Name.to_lower() == "cor"):
		_gui.WriteOutput($CurrentPlayer/Essence.position)

func GetPlayer():
	return CurrentPlayer
