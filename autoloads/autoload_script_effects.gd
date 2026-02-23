extends Node2D
const impact:PackedScene = preload("res://entities/effects/impact/impact.tscn")
const explosion:PackedScene = preload("res://entities/effects/impact/explosion.tscn")
const bad_explosion:PackedScene = preload("res://entities/effects/explosion_bad/scene_anim_explosion.tscn")

func add_vfx_punch(global_pos:Vector2,rot:float) -> void:
	var new:CPUParticles2D = impact.instantiate()
	add_child(new)
	new.global_position = global_pos
	new.rotation = rot
	new.emitting = true

func add_vfx_explode(global_pos:Vector2) -> void:
	var new:CPUParticles2D = explosion.instantiate()
	add_child(new)
	new.global_position = global_pos
	new.emitting = true

func add_bad_explosion(global_pos:Vector2) -> void:
	var new:AnimatedSprite2D = bad_explosion.instantiate()
	add_child(new)
	new.global_position = global_pos
