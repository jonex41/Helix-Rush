extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.score_changed.connect(score_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$TextureRect/CoinValue.text = GameTimer.format_money(GameTimer.initial_coin_balance)
	pass

func score_changed(_score:int):
	#$CoinValue.text = str(score)
	pass
