tool
extends Control

var _object: Object
var _path: String

onready var _icon: TextureRect = $Content/Icon
onready var _label: Label = $Content/Label


func populate(object: Object, path: String) -> void:
	_object = object
	_path = path
	
	if not (is_instance_valid(_icon) and is_instance_valid(_label)):
		yield(self, "ready")
	
	var title := jpInspector.get_category_title(_object, _path)
	_label.text = title
	
	var icon := jpInspector.get_category_icon(_object, _path)
	var texture: Texture = null
	if icon.is_abs_path():
		texture = load(icon)
	
	if texture != null:
		_icon.texture = texture
		_icon.rect_min_size.x = rect_size.y
		_icon.show()
	else:
		_icon.hide()
