extends Node3D
class_name MainLevel

@onready var animation_player: AnimationPlayer = $Cutscene/AnimationPlayer
@onready var player: Player = $Player


func _ready() -> void:
	animation_player.play("CutScene")
	player.cutscene(true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CutScene":
		player.cutscene(false)
		animation_player.queue_free()
