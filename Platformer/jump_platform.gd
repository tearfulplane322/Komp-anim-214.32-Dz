extends Node3D


func _on_area_3d_body_entered(body: Player) -> void:
	if body is Player:
		body.velocity.y = 8.0
