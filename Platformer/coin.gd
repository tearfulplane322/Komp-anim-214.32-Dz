extends Node3D

@onready var BODY: Node3D = $Body
@onready var collision: CollisionShape3D = $Area3D/CollisionShape3D
@onready var reset_coin: Timer = $ResetCoin
@onready var bah: GPUParticles3D = $Bah


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.add_coin(1)
		BODY.visible = false
		collision.disabled = true
		bah.emitting = true
		reset_coin.start()

func _on_reset_coin_timeout() -> void:
	BODY.visible = true
	collision.disabled = false
