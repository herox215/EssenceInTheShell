extends Node

func IsPlayer(object):
	var isPlayer = false
	# Prüft ob object das Attribut Name besitzt und ob Name, wenn vorhanden, nicht leer ist.
	# Dann wird isPlayer auf true gesetzt
	if (object.get("Name") != null && object.get("Name") != ""):
		isPlayer = true
	return isPlayer
