extends CharacterBody3D
class_name Player

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var object_to_interact: Node3D = null

@onready var pivot := $Pivot
@onready var animation_player := $AnimationPlayer
@onready var interaction_indicator := $InteractionIndicator
@onready var combine_indicator := $CombineIndicator
@onready var state_machine := $StateMachine
@onready var inventory := $Inventory


func _ready() -> void:
	GameManager.player = self
