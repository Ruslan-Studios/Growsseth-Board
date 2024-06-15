extends Node

const CYLINDRICAL_VILLAGER = preload("res://textures/cards/artwork/CylindricalVillager.png")

func _ready():
	if CYLINDRICAL_VILLAGER == null:
		get_tree().quit()
	else:
		print("Game integrity check passed.")
