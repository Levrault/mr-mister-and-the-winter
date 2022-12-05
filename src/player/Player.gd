extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var object_to_interact: Node3D = null

@onready var pivot := $Pivot
@onready var animation_player := $AnimationPlayer
@onready var exclamation_point := $ExclamationPoint
@onready var state_machine := $StateMachine
