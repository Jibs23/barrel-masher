extends Node

var highscores:Array[int] = []
var current_score:int = 0

signal score_added(score:int)

func add_score(score:int) -> void:
	highscores.append(score)
	highscores.sort()
	highscores.reverse()
	score_added.emit(score)
	current_score = score

func get_highscore() -> int:
	highscores.sort()
	highscores.reverse()
	return highscores[0]
