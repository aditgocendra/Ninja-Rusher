extends CanvasLayer

onready var admob = $AdMob



func _ready():
	loadAds()
# warning-ignore:return_value_discarded
	#$AdsenseMobile.connect("screen_resized", self, "_on_resize")


func loadAds():
	admob.load_interstitial()

#func _on_resize():
#	admob.banner_resize()
#
#func show_banner():
#	admob.show_banner()
	
func show_interesial():
	admob.show_interstitial()


func _on_AdMob_interstitial_failed_to_load(error_code):
	$ErrorLabel.text = str(error_code)
