class_name Card3D extends Node3D

@export var card_data: CardData

@onready var layout = %Layout
@onready var artwork = %Artwork
@onready var card_name = %Name
@onready var type = %Type
@onready var description = %Description
@onready var lore = %Lore

# Layout e back
const LAYOUT_RIC = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_EGO = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_PRE = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_TOL = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_NET = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_END = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_DEFAULT = preload("res://textures/cards/layout/layout_default.png")

const BACK_RIC = preload("res://textures/cards/layout/layout_nether.png")
const BACK_EGO = preload("res://textures/cards/layout/layout_nether.png")
const BACK_PRE = preload("res://textures/cards/layout/layout_nether.png")
const BACK_TOL = preload("res://textures/cards/layout/layout_nether.png")
const BACK_NET = preload("res://textures/cards/layout/layout_nether.png")
const BACK_END = preload("res://textures/cards/layout/layout_nether.png")

# Animazioni
const ANIM_SPEED = 9
var target_position: Transform3D
var target_rotation: Vector3

var isHighlighted: bool = false
@export var highlight_offset: float = 0.8

# Card unhighlight
var prev_rot: Vector3

# Card Info
const CARD_INFO_SCREEN = preload("res://scenes/components/CardInfoScreen.tscn")

func _ready():
	if card_data == null:
		return
	card_setup()

func _process(delta):
	transform.origin = lerp(transform.origin, target_position.origin, ANIM_SPEED * delta)
	rotation.z = lerp(rotation.z, target_rotation.z, ANIM_SPEED * delta)

func card_setup():
	# Layout - DECK_TYPES { RIC, EGO, PRE, TOL, NET, END }
	# TO-DO: Modificare anche i back appena disponibili
	match card_data.deck_type:
		Deck.DECK_TYPES.RIC:
			layout.texture = LAYOUT_RIC
		Deck.DECK_TYPES.EGO:
			layout.texture = LAYOUT_DEFAULT
		Deck.DECK_TYPES.PRE:
			layout.texture = LAYOUT_PRE
		Deck.DECK_TYPES.TOL:
			layout.texture = LAYOUT_TOL
		Deck.DECK_TYPES.NET:
			layout.texture = LAYOUT_NET
		Deck.DECK_TYPES.END:
			layout.texture = LAYOUT_END
		_:
			layout.texture = LAYOUT_DEFAULT
	
	# Artwork
	artwork.texture = card_data.artwork

	# Card type - CARD_TYPES { T, TS, S }
	match card_data.card_type:
		CardData.CARD_TYPES.T:
			type.text = "[center]T[/center]"
		CardData.CARD_TYPES.TS:
			type.text = "[center]TS[/center]"
		CardData.CARD_TYPES.S:
			type.text = "[center]S[/center]"
	
	# Description
	card_name.text = card_data.card_name
	
	# Description
	description.text = "[fill]" + card_data.description + "[/fill]"
	
	# Lore
	lore.text = "[center]" + card_data.lore + "[/center]"

func show_card_info():
	var card_info = CARD_INFO_SCREEN.instantiate()
	card_info.card_data = self.card_data
	add_child(card_info)

# Funzione chiamata dalla cam
func highlight_card():
	isHighlighted = true
	target_position.origin.y += highlight_offset
	target_position.origin.z += highlight_offset
	prev_rot = target_rotation
	target_rotation.z = 0
	# Eventuali effetti visivi

func unhighlight_card():
	isHighlighted = false
	target_position.origin.y -= highlight_offset
	target_position.origin.z -= highlight_offset
	target_rotation = prev_rot
	# Eventuali effetti visivi
