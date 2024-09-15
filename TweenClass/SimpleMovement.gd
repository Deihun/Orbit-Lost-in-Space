extends Node
var tween = create_tween()

func MoveObjectSmoothly(ObjectName, Location, Duration):
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE) 
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(ObjectName, "position", Location, Duration)
