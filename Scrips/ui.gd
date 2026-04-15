extends CanvasLayer


@onready var coin_label=$Control/Label

func set_coin(amount):
	coin_label.text=str(amount)
