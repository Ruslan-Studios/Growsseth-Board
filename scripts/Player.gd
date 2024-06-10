extends User
class_name Player

var user: User
var faction: int
var cards: Array[Card] = []
var inventory: Array = []

const MAX_HP: int = 20
const MAX_EXP: int = 20
var hp: int
var exp: int
var tile_x: int
var tile_y: int

func _ready():
	pass

func _process(delta):
	pass
