class_name PlayerKeybindResource
extends Resource

const MOVE_LEFT : String = "ui_left"
const MOVE_RIGHT : String = "ui_right"
const MOVE_UP : String = "ui_up"
const MOVE_DOWN : String = "ui_down"
const INTERACT : String = "Interact"

@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_INTERACT_KEY = InputEventKey.new()

var ui_left_key = InputEventKey.new()
var ui_right_key = InputEventKey.new()
var ui_up_key = InputEventKey.new()
var ui_down_key = InputEventKey.new()
var Interact_key = InputEventKey.new()
