tool
extends EditorInspectorPlugin

const CATEGORY_SCENE = preload("res://addons/jp_inspector/category/Category.tscn")

const Category = preload("res://addons/jp_inspector/category/Category.gd")


func can_handle(object: Object) -> bool:
	return true


func parse_property(
		object: Object,
		type: int,
		path: String,
		hint: int,
		hint_text: String,
		usage: int
) -> bool:
	if type == TYPE_DICTIONARY and path.begins_with(jpInspector.CATEGORY_PREFIX):
		var category: Category = CATEGORY_SCENE.instance()
		category.populate(object, path)
		add_custom_control(category)
		return true
	
	return false
