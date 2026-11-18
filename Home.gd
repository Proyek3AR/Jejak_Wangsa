extends Control

@onready var candi_image: TextureRect = %CandiImage
@onready var placeholder_label: Label = %PlaceholderLabel

func _ready() -> void:
	if candi_image.texture != null:
		placeholder_label.visible = false

	# Samakan warna latar kotak dengan krem hangat gambar candi
	var frame := candi_image.get_parent() as PanelContainer
	var style := frame.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style.bg_color = Color(0.980, 0.953, 0.902, 1)
	frame.add_theme_stylebox_override("panel", style)

	# Buat pinggiran kiri-kanan gambar memudar halus agar tidak ada garis kotak
	var sh := Shader.new()
	sh.code = """
	shader_type canvas_item;
	void fragment() {
		vec4 col = texture(TEXTURE, UV);
		float fade_x = smoothstep(0.0, 0.14, UV.x) * smoothstep(1.0, 0.86, UV.x);
		col.a *= fade_x;
		COLOR = col;
	}
	"""
	var mat := ShaderMaterial.new()
	mat.shader = sh
	candi_image.material = mat

	candi_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	var txt_node := $MainVBox/ScrollArea/Margin/ContentVBox/MenuGrid/CardKuis/HBox/Txt
	if txt_node.has_node("Lbl"):
		txt_node.get_node("Lbl").reparent($MainVBox/BottomNav/NavHBox/NavARItem/VBox)

	# Lengkapi teks tanpa tanda titik-titik (...)
	$MainVBox/ScrollArea/Margin/ContentVBox/HeroCard/HeroVBox/HeroDesc.text = "Candi Hindu unik peninggalan Kerajaan Sunda kuno di pulau kecil Situ Cangkuang."
	$MainVBox/ScrollArea/Margin/ContentVBox/MenuGrid/CardModul/HBox/Txt/Sub.text = "5 modul sejarah Jawa Barat"
	$MainVBox/ScrollArea/Margin/ContentVBox/MenuGrid/CardKameraAR/HBox/Txt/Sub.text = "Pindai prasasti & candi 3D"
	$MainVBox/ScrollArea/Margin/ContentVBox/MenuGrid/CardPeta/HBox/Txt/Sub.text = "Jelajah sebaran situs Jabar"
	$MainVBox/ScrollArea/Margin/ContentVBox/MenuGrid/CardKuis/HBox/Txt/Sub.text = "Uji wawasan 10 soal sejarah"

	_start_floating_animation()


func _start_floating_animation() -> void:
	var start_y := candi_image.position.y
	var tween := create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(candi_image, "position:y", start_y - 8.0, 1.4)
	tween.tween_property(candi_image, "position:y", start_y, 1.4)


func _on_btn_mulai_ar_pressed() -> void:
	print("Buka Kamera AR Candi Cangkuang")
	# Nanti ganti dengan: get_tree().change_scene_to_file("res://ARCamera.tscn")


func _on_btn_modul_pressed() -> void:
	print("Buka Modul Materi")


func _on_btn_kamera_ar_pressed() -> void:
	print("Buka Kamera AR")


func _on_btn_peta_pressed() -> void:
	print("Buka Peta & Lini Masa")


func _on_btn_kuis_pressed() -> void:
	print("Buka Kuis Evaluasi")
