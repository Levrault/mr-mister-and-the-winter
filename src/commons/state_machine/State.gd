extends Node
class_name State
@icon("res://editor/icons/state.svg")

var _state_machine: Node = null
var _parent: State = null


func _ready() -> void:
	await owner.ready

	_state_machine = _get_state_machine(self as Node)
	var parent: = get_parent()
	if not parent.is_in_group("state_machine"):
		_parent = parent as State


func unhandled_input(_event: InputEvent) -> void:
	return


func process(_delta: float) -> void:
	return


func physics_process(_delta: float) -> void:
	return


func enter(_msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _get_state_machine(node: Node):
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
