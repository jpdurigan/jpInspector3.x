extends Button

var _object: Object
var _path: String
var _method: String


func populate(object: Object, path: String) -> void:
	_object = object
	_path = path
	_method = jpInspector.get_button_method(_object, _path)
	text = jpInspector.get_button_title(_object, _path)
	disabled = not _object.get_script().is_tool()
	connect("pressed", self, "_on_pressed")


func _on_pressed() -> void:
	_object.call(_method)
