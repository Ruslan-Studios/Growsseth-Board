extends Node3D

var card_data: CardData

@onready var layout = %Layout
@onready var artwork = %Artwork
@onready var card_name = %Name
@onready var type = %Type
@onready var description = %Description
@onready var lore = %Lore

const LAYOUT_DEFAULT = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_NET = preload("res://textures/cards/layout/layout_nether.png")

func _ready():
	if card_data == null:
		return
	
	# Layout - DECK_TYPES { RIC, EGO, PRE, TOL, NET, END }
	match card_data.deck_type:
		Deck.DECK_TYPES.RIC:
			#layout.texture = LAYOUT_RIC
			pass
		Deck.DECK_TYPES.EGO:
			#layout.texture = LAYOUT_EGO
			pass
		Deck.DECK_TYPES.PRE:
			#layout.texture = LAYOUT_PRE
			pass
		Deck.DECK_TYPES.TOL:
			#layout.texture = LAYOUT_TOL
			pass
		Deck.DECK_TYPES.NET:
			layout.texture = LAYOUT_NET
			pass
		Deck.DECK_TYPES.END:
			#layout.texture = LAYOUT_END
			pass
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
	description.text = "[fill]" + card_data.description + "[/fill]"
	
	# Lore
	lore.text = "[canter]" + card_data.lore + "[/center]"

func _process(delta):
	pass
