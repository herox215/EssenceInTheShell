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
	if(lvlName != "" && lvlName != null):
		print("ChangeLevel started...")
		if($CurrentLevel.get_child_count() > 0):
			# Aktuell wird einfach immer das Level komplett entfernt mitsamt allen Objekten, Positionen usw.
			# Hier muss Logik zum Speichern geschrieben werden, damit beim erneuten Betreten nicht wieder alles neu geladen wird.
			print("Need to clear level cache")
			$CurrentLevel.get_child(0).Close()
			$CurrentLevel.get_child(0).queue_free()
			#$CurrentLevel.remove_child($CurrentLevel.get_child(0))
		
		# Darf später NUR gemacht werden wenn es noch kein Level im Cache gibt.
		# Ansonsten Cache benutzen.
		var LvlToChange = load("res://Scenes/Levels/"+lvlName+".tscn")
		var lvlToChange = LvlToChange.instance()
		print("Level " + lvlName + " loaded")
		
		lvlToChange.SetGameEnvironment(self)
		lvlToChange.Open()
		print("Level ready!")
		
		# Wenn man versucht direkt "add_child" aufzurufen kommt es zu massig Fehlen in der Konsole.
		# Mit Call_Deferred lässt man erst alle Multitreading Prozesse durchlaufen und am Ende fügt man es hinzu.
		$CurrentLevel.call_deferred("add_child", lvlToChange)
		print("Level added.")
	
	if(int(posX) > 0 || int(posY) > 0):
		# Aktuell wird immer davon ausgegangen, dass eine Essence existiert. Das muss auf jeden Fall dynamischer werden.
		CurrentPlayer.SetPosition(posX,posY)
		
	_gui.WriteOutput("Level changed to " + lvlName)
	
		
func ExecuteCommand(command):
	print("Command will be executed: " + command.Name)
	# Wir wollen ein Level ändern
	if(command.Name == "ChangeLevel"):
		ChangeLevel(command.GetValue(0), command.GetValue(1), command.GetValue(2))
	if(command.Name == "Coordinates"):
		$CurrentLevel/Objects/Essence/GUI.WriteOutput($CurrentPlayer/Essence.position)

func GetPlayer():
	return CurrentPlayer

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
