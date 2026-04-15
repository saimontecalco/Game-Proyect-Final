extends CharacterBody2D
const SPEED = 125
const JUMP_VELOCITY = -250
@onready var anim = $Sprite2D
@onready var jump_sound = $Jump
var coins = 0
var jumps_left = 0  # contador de saltos disponibles
@onready var hub = get_node("/root/Map/CanvasLayer")

func add_coin():
	coins += 1
	hub.set_coin(coins)

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps_left = 2  # resetea los saltos al tocar el suelo

	# Salto y doble salto
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1
		jump_sound.play()

	# Movimiento con A y D
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Animaciones
	if not is_on_floor() && velocity.y < 0:
		anim.play("Jump")
	elif direction != 0:
		anim.play("Walk")
	else:
		anim.play("Idle")
