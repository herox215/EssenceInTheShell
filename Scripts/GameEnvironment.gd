extends Node2D

var _currentPlayer = null
var _gui = null

func _ready():
	_currentPlayer = _createPlayer()
	_gui = _createGui()
	
	_currentPlayer.add_child(_gui)
	
	$CurrentPlayer.add_child(_currentPlayer)
	ChangeLevel("TestRealm")

func _createGui():
	var gui = load("res://Scenes/GUI/GUI.tscn").instance()
	gui.SetGameEnvironment(self)
	return gui;

# Erstellt einen neuen Spieler, optional mit Kamera.
func _createPlayer():
	var newPlayer = load("res://Scenes/Essence.tscn").instance()
		
	return newPlayer

# Ändert das aktuelle Level.
# Optional kann die Position mit angegeben werden.
func ChangeLevel(lvlName, posX = 0, posY= 0):
	if(lvlName != "" && lvlName != null):
		# Darf später NUR gemacht werden wenn es noch kein Level im Cache gibt.
		# Ansonsten Cache benutzen.
		var LvlToChange = load("res://Scenes/Levels/"+lvlName+".tscn")
		var lvlToChange = LvlToChange.instance()
		
		if($CurrentLevel.get_child_count() > 0):
			# Aktuell wird einfach immer das Level komplett entfernt mitsamt allen Objekten, Positionen usw.
			# Hier muss Logik zum Speichern geschrieben werden, damit beim erneuten Betreten nicht wieder alles neu geladen wird.
			$CurrentLevel.get_child(0).queue_free()
			
		lvlToChange.SetGameEnvironment(self)
		
		# Wenn man versucht direkt "add_child" aufzurufen kommt es zu massig Fehlen in der Konsole.
		# Mit Call_Deferred lässt man erst alle Multitreading Prozesse durchlaufen und am Ende fügt man es hinzu.
		$CurrentLevel.call_deferred("add_child", lvlToChange)
	
	if(int(posX) > 0 || int(posY) > 0):
		# Aktuell wird immer davon ausgegangen, dass eine Essence existiert. Das muss auf jeden Fall dynamischer werden.
		$CurrentPlayer/Essence.SetPosition(posX,posY)
		
	$CurrentPlayer/Essence/GUI.WriteOutput("Level changed to " + lvlName)
		
func ExecuteCommand(command):
	# Wir wollen ein Level ändern
	if(command.Name == "ChangeLevel"):
		ChangeLevel(command.GetValue(0), command.GetValue(1), command.GetValue(2))
	if(command.Name == "Coordinates"):
		$CurrentPlayer/Essence/GUI.WriteOutput($CurrentPlayer/Essence.position)

