class_name Hand extends Node3D

const CARD_3D = preload("res://scenes/components/Card3D.tscn")

@onready var camera = %PlayerCam

const HAND_WIDTH: float = 4.0

var spread_curve: Curve = preload("res://scenes/components/card_spread_curve.tres")
var height_curve: Curve = preload("res://scenes/components/card_height_curve.tres")
var rotation_curve: Curve = preload("res://scenes/components/card_rotation_curve.tres")

func _ready():
	reorder_cards()

func add_card():
	var card = CARD_3D.instantiate()
	add_child(card)
	reorder_cards()

func remove_card():
	if get_children().size() == 0:
		return
	get_child(get_children().size() - 1).free()
	reorder_cards()

func reorder_cards():
	print("\nRiordinamento carte")
	print("Numero di carte: " + str(get_children().size()))
	for card in get_children():
		var new_pos: Transform3D
		var new_rot: Vector3
		
		var hand_ratio = 0.5
		
		# Calcolo Hand Ratio
		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(get_child_count() - 1)
		
		# Card V-Positioning
		new_pos.origin = height_curve.sample(hand_ratio) * Vector3.UP / 1.5
		
		# Card H-Positioning
		new_pos.origin.x = spread_curve.sample(hand_ratio) * clamp((HAND_WIDTH + get_child_count() / 6), 0, 4.5)
		
		# Orienta le carte verso la telecamera
		new_pos.basis = camera.global_transform.basis
		
		# Sfalsa le carte sull'asse Z
		new_pos.origin += camera.basis * Vector3.BACK * hand_ratio * 0.1
		
		# Ruota le carte
		new_rot += Vector3(0, 0, rotation_curve.sample(hand_ratio) * 0.3) / 2
		
		card.target_position = new_pos
		card.target_rotation = new_rot

func _process(delta):
	pass
