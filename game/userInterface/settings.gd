extends Control

@onready var master_slider = %MasterHSlider
@onready var music_slider = %MusicHSlider
@onready var sfx_slider = %SfxHSlider

@onready var window_option_button = %WindowOptionButton
@onready var v_sync_check_box = %VSyncCheckBox
@onready var scaling_option_button = %ScalingOptionButton
@onready var taa_check_box = %TAACheckBox
@onready var msaa_2d_option_button = %MSAA2DOptionButton
@onready var msaa_3d_option_button = %MSAA3DOptionButton

var on_audio_slider = func(value: float, bus: int):
	AudioServer.set_bus_volume_db(bus, value)
	match bus:
		0:
			SaveManager.set_key("settings", "master_audio", AudioServer.get_bus_volume_db(0))
		1:
			SaveManager.set_key("settings", "sfx_audio", AudioServer.get_bus_volume_db(1))
		2:
			SaveManager.set_key("settings", "music_audio", AudioServer.get_bus_volume_db(2))

func _ready():
	master_slider.value_changed.connect(on_audio_slider.bind(0))
	sfx_slider.value_changed.connect(on_audio_slider.bind(1))
	music_slider.value_changed.connect(on_audio_slider.bind(2))
	
	window_option_button.item_selected.connect(func(selected):
		match selected:
			0:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			1:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		SaveManager.set_key("settings", "window_mode", selected)
	)
	
	v_sync_check_box.toggled.connect(func(value):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if value else DisplayServer.VSYNC_DISABLED)
		SaveManager.set_key("settings", "vsync", value)
	)
	
	scaling_option_button.item_selected.connect(func(selected):
		var rid = get_viewport().get_viewport_rid()
		var scaling: int = RenderingServer.VIEWPORT_SCALING_3D_MODE_BILINEAR
		match selected:
			0:
				scaling = RenderingServer.VIEWPORT_SCALING_3D_MODE_BILINEAR
			1:
				scaling = RenderingServer.VIEWPORT_SCALING_3D_MODE_FSR
			2:
				scaling = RenderingServer.VIEWPORT_SCALING_3D_MODE_FSR2
		RenderingServer.viewport_set_scaling_3d_mode(rid, scaling)
		SaveManager.set_key("settings", "scaling", selected)
	)
	
	taa_check_box.toggled.connect(func(value):
		RenderingServer.viewport_set_use_taa(get_viewport().get_viewport_rid(), value)
		SaveManager.set_key("settings", "taa", value)
	)
	
	msaa_2d_option_button.item_selected.connect(func(selected):
		var rid = get_viewport().get_viewport_rid()
		var msaa: int = RenderingServer.VIEWPORT_MSAA_DISABLED
		match selected:
			0:
				msaa = RenderingServer.VIEWPORT_MSAA_DISABLED
			1:
				msaa = RenderingServer.VIEWPORT_MSAA_2X
			2:
				msaa = RenderingServer.VIEWPORT_MSAA_4X
			3:
				msaa = RenderingServer.VIEWPORT_MSAA_8X
		RenderingServer.viewport_set_msaa_2d(rid, msaa)
		SaveManager.set_key("settings", "msaa_2d", selected)
	)
	
	msaa_3d_option_button.item_selected.connect(func(selected):
		var rid = get_viewport().get_viewport_rid()
		var msaa: int = RenderingServer.VIEWPORT_MSAA_DISABLED
		match selected:
			0:
				msaa = RenderingServer.VIEWPORT_MSAA_DISABLED
			1:
				msaa = RenderingServer.VIEWPORT_MSAA_2X
			2:
				msaa = RenderingServer.VIEWPORT_MSAA_4X
			3:
				msaa = RenderingServer.VIEWPORT_MSAA_8X
		RenderingServer.viewport_set_msaa_3d(rid, msaa)
		SaveManager.set_key("settings", "msaa_3d", selected)
	)
	
	if SaveManager.get_key("settings", "master_audio"):
		master_slider.value_changed.emit(SaveManager.get_key("settings", "master_audio"))
	if SaveManager.get_key("settings", "sfx_audio"):
		sfx_slider.value_changed.emit(SaveManager.get_key("settings", "sfx_audio"))
	if SaveManager.get_key("settings", "music_audio"):
		music_slider.value_changed.emit(SaveManager.get_key("settings", "music_audio"))
	
	if SaveManager.get_key("settings", "vsync"):
		v_sync_check_box.button_pressed = SaveManager.get_key("settings", "vsync")
		v_sync_check_box.toggled.emit(v_sync_check_box.button_pressed)
		
	if SaveManager.get_key("settings", "window_mode"):
		window_option_button.selected = SaveManager.get_key("settings", "window_mode")
		window_option_button.item_selected.emit(window_option_button.selected)
		
	if SaveManager.get_key("settings", "scaling"):
		scaling_option_button.selected = SaveManager.get_key("settings", "scaling")
		scaling_option_button.item_selected.emit(scaling_option_button.selected)
		
	if SaveManager.get_key("settings", "msaa_2d"):
		msaa_2d_option_button.selected = SaveManager.get_key("settings", "msaa_2d")
		msaa_2d_option_button.item_selected.emit(msaa_2d_option_button.selected)
		
	if SaveManager.get_key("settings", "msaa_3d"):
		msaa_3d_option_button.selected = SaveManager.get_key("settings", "msaa_3d")
		msaa_3d_option_button.item_selected.emit(msaa_3d_option_button.selected)
		
	if SaveManager.get_key("settings", "taa"):
		taa_check_box.button_pressed = SaveManager.get_key("settings", "taa")
		taa_check_box.toggled.emit(taa_check_box.button_pressed)
