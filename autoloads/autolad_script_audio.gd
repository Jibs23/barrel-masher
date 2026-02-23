extends Node2D

@export var sfx:Array[AudioStreamWAV] = []

var music:AudioStreamPlayer = null

func play_sfx_punch() -> AudioStreamPlayer2D:
	var chosen:AudioStreamPlayer2D = null
	for child:AudioStreamPlayer2D in get_children(): # pick one that is not playing.
		if child.playing: continue
		chosen = child
		#print("chosen is ",child)
		break
	if !chosen: # chose the one closest to being finished instead.
		for child:AudioStreamPlayer2D in get_children():
			if chosen == null: chosen = child
			elif chosen.stream.get_length() < child.stream.get_length():
				chosen = child
				#print("ok fine, chosen is just gonna be ",child)
	chosen.stream = get_random_stream()
	chosen.play()
	return chosen
	
func get_random_stream() -> AudioStreamWAV:
	return sfx.pick_random()

func play_music() -> void:
	if music: music.play()
