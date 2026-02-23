extends Node2D

@export var hit_marker:Marker2D
@export var right_fist:PathFollow2D
@export var left_fist:PathFollow2D
signal hit_barrel()

func punch(right:bool) -> void:
	var fist:PathFollow2D = right_fist if right else left_fist
	fist.punch_at(hit_marker.global_position)
	
func _on_barrel_hit(_target: Vector2) -> void:
	@warning_ignore("integer_division")
	punch(randi() % 2 == 1) # 50% chance
	hit_barrel.emit()

func _process(_delta: float) -> void:
	$PathLeft.curve.set_point_position(1,hit_marker.global_position-position)
	$PathRight.curve.set_point_position(1,hit_marker.global_position-position)
