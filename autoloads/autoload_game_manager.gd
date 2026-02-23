extends Node
## Game States
enum GMST {READY,PLAYING,LOADING,GAMEOVER}
var game_state:GMST = GMST.LOADING
var screen_gameover:CanvasLayer
var screen_ui:CanvasLayer
var screen_ready:CanvasLayer
var barrel:RigidBody2D

signal game_state_changed(new:GMST)

func _unhandled_input(event: InputEvent) -> void:
	if game_state == GameManager.GMST.GAMEOVER and event.is_action_pressed("restart"):
		restart_game()

func _ready() -> void:
	set_game_state(GMST.READY,GMST.LOADING)

func restart_game() -> void:
		set_game_state(GMST.LOADING,GMST.GAMEOVER)
		get_tree().reload_current_scene()
		set_game_state(GMST.READY,GMST.LOADING)

func can_player_input() -> bool:
	if game_state == GMST.LOADING or game_state == GMST.GAMEOVER: 
		return false
	return true

func set_game_state(new:GMST,current:GMST) -> bool:
	if game_state != current: return false
	game_state = new
	game_state_changed.emit(new)
	print("gamestate = ",GMST.keys()[new])
	return true
	
func _start_game() -> void:
	set_game_state(GMST.PLAYING,GMST.READY)
	screen_ui.visible = true
	screen_ready.visible = false
	Audio.play_music()

func _on_game_timeout() -> void:
	set_game_state(GMST.GAMEOVER,GMST.PLAYING)
	screen_ui.visible = false
	screen_gameover.visible = true
	barrel.destroy()
