extends Control



func set_value(value):
	print("changing dropbox_radial_progressbar: ", value)
	$TextureProgressBar.value = value
	if value > 0:
		self.show()
	else: self.hide()
