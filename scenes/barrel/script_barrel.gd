extends RigidBody2D
@export var rope:Line2D
@export var hit_force:float = 150
@export var fists:Node2D

signal hit(target:Vector2)

func _ready() -> void:
	GameManager.barrel = self

func _process(_delta: float) -> void:
	rope.points[1] = $RopeLink.global_position

func _on_key_tracker_key_pressed(_key: String, _count: int) -> void:
	if GameManager.game_state == GameManager.GMST.PLAYING or GameManager.game_state == GameManager.GMST.READY:
		_hit()

func _get_random_vector() -> Vector2:
	return Vector2(randf_range(-1,1),randf_range(-1,1))

func _hit() -> void:
	var dir = _get_random_vector()
	_move_hitmarker(dir)
	#print("dir: ",dir)
	hit.emit($HitMarker.position)
	await fists.hit_barrel
	apply_central_impulse(dir*hit_force)

func _move_hitmarker(dir:Vector2) -> void:
	$HitMarker.position = Vector2(dir.x*$CollisionShape2D.shape.radius,dir.y*($CollisionShape2D.shape.height/2))

signal destoryed

func destroy() -> void:
	Effects.add_bad_explosion(global_position)
	destoryed.emit()
