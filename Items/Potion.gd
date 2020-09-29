extends Area2D

# signal potion_collected

onready var anim = get_node("AnimationPlayer")

func _on_Potion_body_entered(body: Node) -> void:
    # queue_free()  # delete the potion
    anim.play("potion_bounce")
    body.add_potion()
    # emit_signal("potion_collected")
    

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
    queue_free()
