extends Actor

export var direction = 1  # assume -1 is left and 1 is right
export var detect_cliffs = true

onready var anim = get_node("AnimatedSprite")
onready var patrol_bound = get_node("PatrolBoundary")
onready var vealth = 5

var velocity = Vector2()

func _ready() -> void:
    if direction == 1:
        anim.flip_h = true 
    elif direction == -1:
        anim.flip_h = false
    
    patrol_bound.enabled = detect_cliffs
    # Set patrol to 20 pts ahead/behind the shape's edge
    patrol_bound.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta: float) -> void:
    patrol()


func patrol() -> void:
    if is_on_wall() or not patrol_walking_on_floor() and detect_cliffs:
        direction *= -1
        anim.flip_h = not anim.flip_h
        patrol_bound.position.x = $CollisionShape2D.shape.get_extents().x * direction

    velocity.y += gravity
    velocity.x = speed * direction
    anim.play()

    velocity = move_and_slide(velocity, Vector2.UP)


func patrol_walking_on_floor():
    return patrol_bound.is_colliding() and is_on_floor()
