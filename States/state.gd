extends Node2D

class_name State

var change_state: Callable
var animated_sprite: AnimatedSprite2D
var player: CharacterBody2D

func setup(change_state, animated_sprite, player):
	self.change_state = change_state
	self.animated_sprite = animated_sprite
	self.player = player
