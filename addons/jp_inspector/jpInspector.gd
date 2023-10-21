extends Reference
class_name jpInspector

const CATEGORY_PREFIX = "_c_"

static func get_category_title(object: Object, path: String) -> String:
	printt(
		path,
		path.replace(CATEGORY_PREFIX, ""),
		path.replace(CATEGORY_PREFIX, "").capitalize()
	)
	return path.replace(CATEGORY_PREFIX, "").capitalize()
