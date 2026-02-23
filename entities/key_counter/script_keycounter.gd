extends Node

var keys:Dictionary[String,int] = {}

signal key_pressed(key:String,count:int)

func _ready() -> void:
	connect("key_pressed",Callable(GameManager,"_start_game").unbind(2),CONNECT_ONE_SHOT)
	GameManager.connect("game_state_changed",Callable(self,"_on_game_state_changed"))

func _unhandled_key_input(event: InputEvent) -> void:
	if !GameManager.can_player_input(): return
	if event.is_echo() or event.is_released() or event is not InputEventKey: 
		return
	var digit:String = event.as_text()
	if !keys.has(digit): 
		keys[digit] = 1
	else: keys[digit] += 1
	key_pressed.emit(digit,keys[digit])
	#print(digit," is ",keys[digit])
	#print("total: ",_get_total_score())

func _get_total_score() -> int:
	var output:int = 0
	for value:String in keys:
		output += keys[value]
	return output

## TODO: fix this shit lol.
func _get_most_used_key() -> Dictionary[String,int]:
	var output:Dictionary[String,int] = {}
	for value in keys:
		if keys[value] > output.values()[1] or output.is_empty():
			output.erase(0)
			output[value] = keys[value]
	return output

func _on_timer_timeout() -> void:
	GameData.add_score(_get_total_score())
