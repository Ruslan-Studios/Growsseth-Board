extends Node

#	Title: MAP GENERATOR
#	Description: Map generator based on a seed
#   Made by: NoelEm

# Preload the tile scene
@onready var waterTile: PackedScene = preload("res://scenes/tiles/waterTile.tscn")
@onready var sandTile: PackedScene = preload("res://scenes/tiles/sandTile.tscn")
@onready var caveTile: PackedScene = preload("res://scenes/tiles/caveTile.tscn")
@onready var plainsTile: PackedScene = preload("res://scenes/tiles/plainsTile.tscn")
@onready var forestTile: PackedScene = preload("res://scenes/tiles/forestTile.tscn")

@onready var endTile: PackedScene = preload("res://scenes/tiles/structures/endTile.tscn")
@onready var ricTile: PackedScene = preload("res://scenes/tiles/spawns/ricTile.tscn")
@onready var predTile: PackedScene = preload("res://scenes/tiles/spawns/predTile.tscn")
@onready var egoTile: PackedScene = preload("res://scenes/tiles/spawns/egoTile.tscn")

@onready var tiles_: Dictionary = {
	"9": caveTile,
	"8": caveTile,
	"7": forestTile,
	"6": forestTile,
	"5": plainsTile,
	"4": plainsTile,
	"3": sandTile,
	"2": sandTile,
	"1": waterTile,
	"0": waterTile,
	"11": endTile,
	"12": ricTile,
	"13": predTile,
	"14": egoTile
}

var mapSize_ = [17, 9]
var map = []

# Seed for map generation
@export var seed_: String = "MelminaVerde"
var mapWidth_ = 17
var mapHeight_ = 9

# Convert string seed to a number
func seedToNumber(seed: String) -> int:
	var hashed = hash(seed) % 999999999999999999
	return hashed

func instantiate_tile(key: int, coords):
	var toTile = null
	if tiles_.has(str(key)):
		toTile = tiles_[str(key)].instantiate()
	
	if toTile != null:
		toTile.position = Vector3(coords[0], 0, coords[1])
		add_child(toTile)

func instanceMap():
	for x in range(mapSize_[0]):
		for y in range(mapSize_[1]):
			instantiate_tile(map[x][y], Vector2(x, y))

func generateEnd():
	map[8][4] = 11
	map[7][3] = 1
	map[7][4] = 1
	map[7][5] = 1
	map[8][3] = 1
	map[8][5] = 1
	map[9][3] = 1
	map[9][4] = 1
	map[9][5] = 1

func numberToDigit(number: String) -> int:
	var n = 0
	for x in number:
		n += int(x)
	
	return n
	
func map_to_percentage(value, from_min, from_max, to_min, to_max):
	# Calcola la percentuale del valore rispetto al range originale
	var percentage = (value - from_min) / float(from_max - from_min)
	# Applica la percentuale al nuovo range
	return to_min + percentage * (to_max - to_min)

func checkDistance(seed, value, secondValue, minDistance, pos1, center):
	if ( sqrt( pow((pos1.x - center.x), 2) +  pow((pos1.y - center.y), 2)) > minDistance ) :
		if(abs(value - secondValue) < minDistance):
			value = minDistance + abs(value - secondValue) if fmod(seed, 2) else +(minDistance - abs(value - secondValue) )
	return value

func generateSpawns(seedInt):
	var pos1 = Vector2()
	var pos2 = Vector2()
	var pos3 = Vector2()
	
	var leftSeed = str(seedInt).left(str(seedInt).length() / 2)
	var rightSeed = str(seedInt).right(str(seedInt).length() / 2)
	
	leftSeed = numberToDigit(leftSeed)
	rightSeed = numberToDigit(rightSeed)
	var center = Vector2(8, 4)
	var mapX = round(map_to_percentage(leftSeed, 1, 81, 0, 16))
	var mapY = round(map_to_percentage(rightSeed, 1, 81, 0, 8))
	mapY = checkDistance(seedInt, mapY, center.y, 3.5 , pos1, center)
	mapX = checkDistance(seedInt, mapX, center.x, 5 , pos1, center)
	pos1 = Vector2(mapX, mapY)
	print(pos1)
	
	var distance = sqrt( pow((pos1.x - center.x), 2) +  pow((pos1.y - center.y), 2))
	var angle = atan2(center.y - pos1.y, center.x - pos1.x)
	var points = []
	for i in range(3):
		var new_angle = angle + i * (2 * PI / 3)  # 120° = 2 * PI / 3
		var x = clamp(round(center.x + distance * cos(new_angle)), 0, mapSize_[0])
		var y = clamp(round(center.y + distance * sin(new_angle)), 0, mapSize_[1] - 1)
		points.append(Vector2(x, y))
	
	pos1 = points[2]
	pos2 = points[1]
	pos3 = points[0]
	instantiate_tile(12, pos1)
	instantiate_tile(13, pos2)
	instantiate_tile(14, pos3)
	
	print("pos3:", pos3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for x in range(mapSize_[0]):
		var row = []
		for y in range(mapSize_[1]):
			row.append(-1)
		map.append(row)
	
	var seed_int = seedToNumber(seed_)
	var melmina_seed = seedToNumber("MelminaVerd")
	
	var noise = FastNoiseLite.new()
	noise.seed = seed_int
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	noise.frequency = 0.075
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.fractal_lacunarity = 0.99
	noise.fractal_gain = 2
	noise.fractal_weighted_strength = 3
	
	if seed_int == melmina_seed:
		print("Sei stato MelminaVerdato")
	else:
		for x in range(mapSize_[0]):
			for y in range(mapSize_[1]):
				var noise_value = noise.get_noise_2d(x, y)
				var int_value = convert_noise_to_int(noise_value)
				
				map[x][y] = int_value
				#instantiate_tile(int_value, Vector2(x, y))
		
		
		generateSpawns(seed_int)
		generateEnd()
		instanceMap()
		print("Sono sad, ma gioca")
		

func convert_noise_to_int(numb: float) -> int:
	if numb == 0:
		return 0
	while abs(numb) < 1.0:
		numb *= 10
	return int(abs(numb))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
