class_name AnimationManager
extends Node

@onready var animator:AnimatedSprite2D = get_node("../animator")

func play(animation):
	animator.play(animation)
