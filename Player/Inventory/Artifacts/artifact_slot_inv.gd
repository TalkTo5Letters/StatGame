extends Button
var info_vis
var artifact_data
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$TextureRect.set_texture(load(artifact_data.get("texture")))
	$RichTextLabel.append_text(artifact_data.get("name"))
	$RichTextLabel.newline()
	$RichTextLabel.newline()
	$RichTextLabel.append_text("Description:")
	$RichTextLabel.newline()
	$RichTextLabel.append_text(artifact_data.get("description"))
	$RichTextLabel.newline()
	$RichTextLabel.append_text("Effects:")
	$RichTextLabel.newline()
	for i in artifact_data.get("effects"):
		var effect_text = i + ": " + str(artifact_data.get("effects").get(i))
		$RichTextLabel.append_text(effect_text)
		$RichTextLabel.newline()
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if info_vis == true:
		info_vis = false
		$RichTextLabel.visible = false
	else:
		info_vis = true
		$RichTextLabel.visible = true
