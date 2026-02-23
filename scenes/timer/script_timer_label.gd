extends Label

func _ready() -> void:
	$Timer.connect("timeout",Callable(GameManager,"_on_game_timeout"))
	GameManager.connect("game_state_changed",Callable(self,"_on_game_state_changed"))

func _on_timer_timeout() -> void:
	pass

func _on_game_state_changed(new:GameManager.GMST) -> void:
	if new == GameManager.GMST.PLAYING: $Timer.start()

func _process(_delta: float) -> void:
	text = str(float($Timer.time_left)).erase(4,13)
