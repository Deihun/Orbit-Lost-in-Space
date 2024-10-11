extends ScrollContainer
@export var ReportTab : PackedScene
@export var rangeDistance : int = 50
@onready var container = $VBoxContainer


func onCall():
	var distance = 0
	while IngameStoredProcessSetting.Cycle_ReportList.size() > 0:
		distance += 1
		var Info = IngameStoredProcessSetting.Cycle_ReportList.pop_front()
		var instance = ReportTab.instantiate()
		#instance.position = Vector2(instance.position.x , instance.position.y - (distance * rangeDistance))
		instance.set_data(str(Info[0], " (",Info[1],")"))
		container.add_child(instance)
		print(distance, " : this is being instantiate")


func deleteChild():
	for child in container.get_children():
		child.queue_free()
	pass
