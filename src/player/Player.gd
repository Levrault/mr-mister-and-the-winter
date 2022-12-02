extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var model := $Model
@onready var animation_player := $AnimationPlayer
