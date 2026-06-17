extends Node3D

@onready var BODY: Node3D = $Body
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.take_damage(1)
		queue_free()
	
