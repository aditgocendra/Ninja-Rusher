extends CanvasLayer

onready var admob = $AdMob



func _ready():
	loadAds()
# warning-ignore:return_value_discarded
	#$AdsenseMobile.connect("screen_resized", self, "_on_resize")


func loadAds():
	admob.load_rewarded_video()

#func _on_resize():
#	admob.banner_resize()
#
#func show_banner():
#	admob.show_banner()
	
func show_ads():
	admob.show_rewarded_video()


