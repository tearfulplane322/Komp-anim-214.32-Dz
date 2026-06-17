extends CharacterBody3D
class_name Player


@onready var body: Node3D = $Body
@onready var hud: Control = $Hud	
@onready var animation_tree: AnimationTree = $Body/Untitled/AnimationTree

const ROTATION_SPEED = 10.0
const MAX_HP = 3

var hp: int = MAX_HP
var speed: float = 5.0
const JUMP_VELOCITY = 4.5

var coin: int

var can_move: bool

enum animations {
	IDLE,
	RUN,
	JUMP
}
var current_anim = animations.IDLE

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if can_move == true:
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		
		var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction != Vector3.ZERO:
			var target_yaw := atan2(-direction.x, -direction.z)
			body.rotation.y = lerp_angle(body.rotation.y, target_yaw, ROTATION_SPEED * delta)
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			current_anim = animations.RUN
			animation_tree.set("parameters/DANCE/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
			current_anim = animations.IDLE

	hendle_anim()
	move_and_slide()

	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("UI/MainMenu/main_menu.tscn")
	
	if Input.is_action_just_pressed("Use") and current_anim == animations.IDLE:
		animation_tree.set("parameters/DANCE/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		
func hendle_anim() -> void:
	match current_anim:
		animations.RUN:
			animation_tree.set("parameters/Movement/transition_request", "Run")
		animations.IDLE:
			animation_tree.set("parameters/Movement/transition_request", "Idle")
		animations.JUMP:
			animation_tree.set("parameters/Movement/transition_request", "Jump")

func add_coin(COIN: int):
	coin += COIN
	hud.update_coin_display()

func take_damage(damage: int) -> void:
	hp -= damage
	hp = max(hp, 0)
	hud.update_hp_display()
	if hp == 0:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		can_move = false
		die()

func die() -> void:
	animation_tree.set("parameters/Dead/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	await animation_tree.animation_finished
	get_tree().change_scene_to_file("UI/MainMenu/main_menu.tscn")
	
	
func cutscene(active: bool):
	if active == true:
		can_move = false
	else:
		can_move = true
	
