extends Label

var coins = 0

func _ready():
	text = String(coins)

func _on_Coin_coinCollected():
	coins = coins + 1
	print(coins)
	_ready()
	
	if(coins == 5):
		get_tree().change_scene("res://Scenes/VictoryScreen.tscn")
	_ready()
