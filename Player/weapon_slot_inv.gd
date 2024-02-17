extends TextureButton
var info_vis
var weapon_data
# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture_normal(load(weapon_data.get("texture")))
	$RichTextLabel.append_text(weapon_data.get("name"))
	$RichTextLabel.newline()
	$RichTextLabel.append_text("Damege: "  + str(weapon_data.get("damage")))
	$RichTextLabel.newline()
	$RichTextLabel.newline()
	$RichTextLabel.append_text("Description:")
	$RichTextLabel.newline()
	$RichTextLabel.append_text(weapon_data.get("description"))
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
