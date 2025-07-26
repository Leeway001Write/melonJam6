extends Enemy

signal died # Guess I'll die

func _die():
	died.emit()
	super()
