extends Actor

signal potion_collected(potion_count)

# Settings

# Properties
var velocity = Vector2()
var potions = 0

onready var anim = get_node("AnimatedSprite")

func _process(delta: float) -> void:
    if Input.is_action_pressed("attack"):
        anim.play("normal_attack")

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("ui_right"):
        velocity.x += speed
        anim.flip_h = false
        anim.play("run_right")
    elif Input.is_action_pressed("ui_left"):
        velocity.x -= speed
        anim.flip_h = true
        anim.play("run_right")
    else:
        anim.play("idle")
    
    if not is_on_floor():
        anim.play("hangtime")
    # Player will FALL faster and faster on the way down.
    velocity.y += gravity

    # is_on_floor() requires use of Vector2.UP to tell game where the floor is!
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_force
        anim.play("jump")

    move_and_slide(velocity, Vector2.UP)
    # Smooths out the character motion. Try turning on/off to see difference
    velocity.x = lerp(velocity.x, 0, 0.2)

func _unhandled_key_input(event: InputEventKey) -> void:
    if event.is_action_pressed("attack"):
        anim.play("normal_attack")

func add_potion():
    self.potions += 1
    emit_signal("potion_collected", potions)

# Signal Handlers
func _on_FallZone_body_entered(body: Node) -> void:
    # get_tree().change_scene("res://Scenes/BridgeScene.tscn")
    # get_tree().reload_current_scene()
    pass
