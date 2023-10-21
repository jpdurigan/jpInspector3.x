extends Reference
class_name jpInspector

const CATEGORY_PREFIX = "_c_"
const CATEGORY_KEY_TITLE = "title"
const CATEGORY_KEY_ICON = "icon"

const GROUP_PREFIX = "_g_"
const GROUP_KEY_VARIABLES = "variables"
const GROUP_KEY_TITLE = "title"


static func Category(title: String = "", icon: String = "") -> Dictionary:
	return {
		CATEGORY_KEY_TITLE: title,
		CATEGORY_KEY_ICON: icon,
	}


static func Group(variables: Array = [], title: String = "") -> Dictionary:
	return {
		GROUP_KEY_VARIABLES: variables,
		GROUP_KEY_TITLE: title,
	}



static func get_category_title(object: Object, path: String) -> String:
	var title: String = ""
	var category: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(category, CATEGORY_KEY_TITLE):
		title = category[CATEGORY_KEY_TITLE]
	if title.empty():
		title = path.replace(CATEGORY_PREFIX, "").capitalize()
	return title


static func get_category_icon(object: Object, path: String) -> String:
	var icon: String = ""
	var category: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(category, CATEGORY_KEY_ICON):
		icon = category[CATEGORY_KEY_ICON]
	return icon


static func get_group_variables(object: Object, path: String) -> Array:
	var variables: Array
	var group: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(group, GROUP_KEY_VARIABLES):
		variables = group[GROUP_KEY_VARIABLES]
	if variables.empty():
		for property in object.get_property_list():
			var name: String = property.name
			if name != path and name.begins_with(path):
				variables.append(name)
	return variables


static func get_group_title(object: Object, path: String) -> String:
	var title: String = ""
	var group: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(group, GROUP_KEY_TITLE):
		title = group[GROUP_KEY_TITLE]
	if title.empty():
		title = path.replace(GROUP_PREFIX, "").capitalize()
	return title


static func _eval_from_object(object: Object, path: String) -> Dictionary:
	var dict: Dictionary = {}
	var script: Script = object.get_script()
	if script != null and not script.is_tool():
		var code: String = script.source_code
		code = code.right(code.find(path))
		code = code.left(code.find("\n"))
		var idx = code.find("jpInspector")
		if idx >= 0:
			code = code.right(code.find("jpInspector"))
			dict = _eval_gdscript(code)
	if dict.empty():
		dict = object.get(path)
	
	return dict


static func _eval_gdscript(code: String) -> Dictionary:
	var gdscript := GDScript.new()
	gdscript.source_code = """
extends Reference

func eval() -> Dictionary:
	return %s
	""" % code
	gdscript.reload()
	var instance: Reference = gdscript.new()
	var value: Dictionary = instance.call("eval")
	return value


static func _dict_has_string(dict: Dictionary, key) -> bool:
	return (
		dict.has(key)
		and typeof(dict[key]) == TYPE_STRING
		and not dict[key].empty()
	)
