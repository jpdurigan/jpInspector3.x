tool
extends Control

var _object: Object
var _path: String

onready var _label: Label = $Content/Label


func populate(object: Object, path: String) -> void:
	_object = object
	_path = path
	
	if not is_instance_valid(_label):
		yield(self, "ready")
	
	var title := jpInspector.get_category_title(_object, _path)
	_label.text = title
