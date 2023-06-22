extends Area

signal coinCollected

func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _physics_process(delta):
	rotate_y(deg2rad(2))

func _on_Coin_body_entered(body):
	if body.name == "player":
		emit_signal("coinCollected")
		queue_free()
