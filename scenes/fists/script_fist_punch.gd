extends PathFollow2D


enum STATES {READY,WINDUP,PUNCH,IMPACT,RESETTING}
var state:STATES = STATES.READY
var reset_pos:Vector2 = position
@onready var sprite:Sprite2D = $Fist

func punch_at(_pos:Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(self,"progress_ratio",1,.05)
	await tween.finished
	Effects.add_vfx_punch(global_position,rotation)
	Effects.add_vfx_explode(global_position)
	Audio.play_sfx_punch()
	pull_back()

func pull_back() -> void:
	var tween = create_tween()
	tween.tween_property(self,"progress_ratio",0,.1).set_trans(Tween.TRANS_BACK)
