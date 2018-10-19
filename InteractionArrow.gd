extends Node2D

signal player_sighted(entered)

export(bool) var player_in_sight = false
export(bool) var use_press_e_sprite = false
var press_e_sprite = preload("res://arrow_e.png")

func _ready():
	if use_press_e_sprite:
		$Sprite.set_texture(press_e_sprite)

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		$AnimationPlayer.play("Show")
		player_in_sight = true
		emit_signal("player_sighted", player_in_sight)

func _on_Area2D_area_exited(area):
	if area.get_parent().is_in_group("Player"):
		$AnimationPlayer.play("RESET")
		player_in_sight = false
		emit_signal("player_sighted", player_in_sight)
