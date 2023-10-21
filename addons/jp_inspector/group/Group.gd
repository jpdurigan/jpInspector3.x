tool
extends Control

var _object: Object
var _path: String
var _variables: Array
var _update_variables_funcref: FuncRef

onready var _check: CheckBox = $Content/Check
onready var _label: Label = $Content/Label
onready var _button: Button = $Button


func populate(object: Object, path: String, update_variables_funcref: FuncRef, is_group_visible: bool = true) -> void:
	_object = object
	_path = path
	_update_variables_funcref = update_variables_funcref
	
	_variables = jpInspector.get_group_variables(object, path)
	_update_variables(false)
	
	rect_size = Vector2.ZERO
	if not (is_instance_valid(_check) and is_instance_valid(_label) and is_instance_valid(_button)):
		yield(self, "ready")
	
	var title := jpInspector.get_group_title(_object, _path)
	_label.text = title
	
	if is_group_visible() != is_group_visible:
		_button.set_pressed_no_signal(is_group_visible)
		_update_variables()
	_check.set_pressed_no_signal(is_group_visible)
	_button.connect("toggled", self, "_on_button_toggled")
	


func is_group_visible() -> bool:
	if not is_instance_valid(_button):
		return true
	return _button.pressed


func _update_variables(should_update: bool = true) -> void:
	_update_variables_funcref.call_func(_object, _path, _variables, self)
	if should_update:
		_object.property_list_changed_notify()


func _on_button_toggled(button_pressed: bool) -> void:
	_check.pressed = button_pressed
	_update_variables()
