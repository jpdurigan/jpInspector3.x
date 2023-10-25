# jpInspector for Godot 3.x

Define categories, groups and buttons in the inspector using export vars in Godot 3.x!

✅ Works in Godot 3.1 ~ 3.5

## How to

Export a Dictionary var with the defined prefix and it will be rendered as the element in the inspector.

```
export var _c_my_category: Dictionary
export var _g_colors_group: Dictionary = jpInspector.Group("color")
export var color_base: Color = Color.white
export var color_text: Color = Color.black
export var _b_execute: Dictionary
```


You may customize these values in Project Settings.

This plugin can evaluate expressions such as `jpInspector.Group("color")` in non-tool scripts.
To do that, you must declare and initialize the variable in a single line.
You may turn that off in Project Settings as well.

You can also declare custom elements with a plain Dictionary:
```
export var _c_category: Dictionary = {
	jpInspector.CATEGORY_KEY_TITLE: "My actual title"
}
export var _c_category2 = {
	"title": "i like to live dangerously 8)"
}
```

### Category
Default prefix: `_c_`

A category may have a custom `title` and `icon`.

```
export var _c_category: Dictionary = jpInspector.Category("My Category", "res://icon.png")
```

### Group
Default prefix: `_g_`

Groups can control the visibity of properties that share a common `prefix`
or directly specified in `variables`. They can also have custom `title`.
It must be declared before the properties it controls.

```
export var _g_path_group: Dictionary = jpInspector.Group("path_", "NodePaths Group")
export var path_button: NodePath
export var path_label: NodePath
export var path_container: NodePath

export var _g_custom_group: Dictionary = jpInspector.GroupCustom(["page_title", "text", "button_color"])
export var page_title: String
export(String, MULTILINE) var text: String
export var button_color: Color
```

### Button
Default prefix: `_b_`

A button will call a function in the object currently edited. It needs a tool script to work.
You can specify the `method` and its `title`.

```
export var but_custom_function: Dictionary = jpInspector.FuncButton("custom_function")
export var but_button_2: Dictionary = jpInspector.FuncButton("another_custom_function", "Another Custom Function")

func custom_function() -> void:
	printt(self, "Calling custom function!")

func another_custom_function() -> void:
	printt(self, "Calling another custom function!")

```