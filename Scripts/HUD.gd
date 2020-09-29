extends CanvasLayer

var potions = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $PotionCounter.text = "5"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    $PotionCounter.text = String(potions)

func _on_PlayerInstance_potion_collected(potion_count) -> void:
    potions = potion_count

