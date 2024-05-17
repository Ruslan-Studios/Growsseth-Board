extends Node

#	Title: MAP GENERATOR
#	Description: Map generator based on a seed
#   Made by: NoelEm

# Preload the tile scene
@onready var testingTile: PackedScene = preload("res://scenes/tiles/structures/testTile.tscn")

# Dictionary to hold tile instances
var tiles_: Dictionary = {}

# Seed for map generation
@export var seed_: String = "MelminaVerde"

# Convert string seed to a number
func seedToNumber(seed: String) -> int:
	var hashed = hash(seed) % 999999999999999999
	return hashed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../MyCam".current = true
	var seed_int = seedToNumber(seed_)
	var melmina_seed = seedToNumber("MelminaVerde")
	if seed_int == melmina_seed:
		print("Hai appena MelminaVerdato")
		var mapWidth = 17
		var mapHeight = 9
		for i in range(mapWidth):
			for j in range(mapHeight):
				var me = testingTile.instantiate()
				add_child(me)
				me.position = Vector3(i, 0, j)
				print(me.position)
	else:
		print("Sono sad, ma gioca")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
