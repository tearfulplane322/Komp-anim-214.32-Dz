extends Area3D


func _on_body_entered(body: Player) -> void:
	if body is Player:
		body.global_position = Vector3(0, 2, 0)
		body.take_damage(1)
		
