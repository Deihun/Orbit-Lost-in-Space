extends ScrollContainer
@export var ReportTab : PackedScene
@export var rangeDistance : int = 50
@onready var container = $VBoxContainer

#VARIABLE
const delay : float = 0.7
var _Delay : float = delay
var _isDoneShowing : bool = true

func onCall():
	$"../Click_anywhere".hide()
	var distance = 0
	_isDoneShowing = false
	while IngameStoredProcessSetting.Cycle_ReportList.size() > 0:
		distance += 1
		var Info = IngameStoredProcessSetting.Cycle_ReportList.pop_front()
		var instance = ReportTab.instantiate()
		#instance.position = Vector2(instance.position.x , instance.position.y - (distance * rangeDistance))
		instance.set_data(str(Info[0], " (",Info[1],")"))
		container.add_child(instance)
		await get_tree().create_timer(_Delay).timeout 
	
	$"../Click_anywhere".show()
	_isDoneShowing = true
	_Delay = delay


func deleteChild():
	for child in container.get_children():
		child.queue_free()
	pass
