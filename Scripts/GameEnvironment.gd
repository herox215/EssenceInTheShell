extends Node2D

var _currentPlayer = null

func _ready():
	_currentPlayer = _createPlayer(true)
	self.add_child(_currentPlayer)
	ChangeLevel("TestRealm")

# Erstellt einen neuen Spieler, optional mit Kamera.
func _createPlayer(withCamera):
	var newPlayer = load("res://Scenes/Essence.tscn").instance()
	
	if(withCamera == true):
		var cameraToAdd = Camera2D.new()
		cameraToAdd.current = true
		cameraToAdd.zoom.x = 0.5
		cameraToAdd.zoom.y = 0.5
		newPlayer.add_child(cameraToAdd);
		
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
	
	if(posX > 0 || posY > 0):
		# Aktuell wird immer davon ausgegangen, dass eine Essence existiert. Das muss auf jeden Fall dynamischer werden.
		$Essence.SetPosition(posX,posY)
