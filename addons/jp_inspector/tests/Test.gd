extends Node

## Categories

# Simple category
export var _c_category_1: Dictionary
export var var_cat1_bool: bool
export var var_cat1_int: int
export var var_cat1_str: String

export var _c_category_2: Dictionary = jpInspector.Category()
export var var_cat2_bool: bool
export var var_cat2_int: int
export var var_cat2_str: String

# Category with custom title
export var _c_category_3: Dictionary = jpInspector.Category("My Category #3")
export var var_cat3_bool: bool
export var var_cat3_int: int
export var var_cat3_str: String

# Category with custom title and icon
export var _c_category_4: Dictionary = jpInspector.Category("My Category #4", "res://icon.png")
export var var_cat4_bool: bool
export var var_cat4_int: int
export var var_cat4_str: String


## Groups

# Simple group
export var _g_group_1: Dictionary
export var _g_group_1_var_grp1_bool: bool
export var _g_group_1_var_grp1_int: int
export var _g_group_1_var_grp1_str: String

export var _g_group_2: Dictionary = jpInspector.Group()
export var _g_group_2_var_grp1_bool: bool
export var _g_group_2_var_grp1_int: int
export var _g_group_2_var_grp1_str: String

# Simple group with custom title

# Group from a list of properties

# Group from a list of properties with custom title


## Buttons

# Simple button

# Simple button with custom title
