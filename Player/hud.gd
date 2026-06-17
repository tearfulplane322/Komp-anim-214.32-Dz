extends Control

@onready var texture_rect: TextureRect = $HP/TextureRect
@onready var texture_rect_2: TextureRect = $HP/TextureRect2
@onready var texture_rect_3: TextureRect = $HP/TextureRect3
@onready var coin: Label = $Coin

var player: Player
var MAX_COIN: int = 10

func _ready() -> void:
	player = get_parent() as Player
	update_hp_display()
	update_coin_display()

func update_hp_display() -> void:
	if player.hp <= 0:
		texture_rect.visible = false
		texture_rect_2.visible = false
		texture_rect_3.visible = false
	elif player.hp == 1:
		texture_rect.visible = true
		texture_rect_2.visible = false
		texture_rect_3.visible = false
	elif player.hp == 2:
		texture_rect.visible = true
		texture_rect_2.visible = true
		texture_rect_3.visible = false
	else:
		texture_rect.visible = player.hp > 0
		texture_rect_2.visible = player.hp > 1
		texture_rect_3.visible = player.hp > 2


func update_coin_display():
	if player.coin > MAX_COIN:
		player.coin = 0
	coin.text = "Монеты: " + str(player.coin) + " / " + str(MAX_COIN)
