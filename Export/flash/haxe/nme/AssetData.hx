package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("assets/about.png", nme.NME_assets_about_png);
			type.set ("assets/about.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/bounce.mp3", nme.NME_assets_bounce_mp3);
			type.set ("assets/bounce.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/cancel.png", nme.NME_assets_cancel_png);
			type.set ("assets/cancel.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/cancel_inv.png", nme.NME_assets_cancel_inv_png);
			type.set ("assets/cancel_inv.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/checkmark.png", nme.NME_assets_checkmark_png);
			type.set ("assets/checkmark.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/chicago.png", nme.NME_assets_chicago_png);
			type.set ("assets/chicago.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/desktop.png", nme.NME_assets_desktop_png);
			type.set ("assets/desktop.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/fail01.png", nme.NME_assets_fail01_png);
			type.set ("assets/fail01.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/fail02.png", nme.NME_assets_fail02_png);
			type.set ("assets/fail02.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon.png", nme.NME_assets_icon_png);
			type.set ("assets/icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon_tiny.png", nme.NME_assets_icon_tiny_png);
			type.set ("assets/icon_tiny.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/instructions.png", nme.NME_assets_instructions_png);
			type.set ("assets/instructions.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/lose.mp3", nme.NME_assets_lose_mp3);
			type.set ("assets/lose.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/lose.png", nme.NME_assets_lose_png);
			type.set ("assets/lose.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/matchpoint.mp3", nme.NME_assets_matchpoint_mp3);
			type.set ("assets/matchpoint.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/miss.mp3", nme.NME_assets_miss_mp3);
			type.set ("assets/miss.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/ok.png", nme.NME_assets_ok_png);
			type.set ("assets/ok.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/ok_inv.png", nme.NME_assets_ok_inv_png);
			type.set ("assets/ok_inv.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/pixchicago.ttf", nme.NME_assets_pixchicago_ttf);
			type.set ("assets/pixchicago.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/pixchicago_e.ttf", nme.NME_assets_pixchicago_e_ttf);
			type.set ("assets/pixchicago_e.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/pixchicago_e2.ttf", nme.NME_assets_pixchicago_e2_ttf);
			type.set ("assets/pixchicago_e2.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/scoreboard.png", nme.NME_assets_scoreboard_png);
			type.set ("assets/scoreboard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/scorewarning.png", nme.NME_assets_scorewarning_png);
			type.set ("assets/scorewarning.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/septagon.png", nme.NME_assets_septagon_png);
			type.set ("assets/septagon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/setendscore.png", nme.NME_assets_setendscore_png);
			type.set ("assets/setendscore.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/splash.png", nme.NME_assets_splash_png);
			type.set ("assets/splash.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/start.mp3", nme.NME_assets_start_mp3);
			type.set ("assets/start.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/win.mp3", nme.NME_assets_win_mp3);
			type.set ("assets/win.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/win.png", nme.NME_assets_win_png);
			type.set ("assets/win.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/window_border.png", nme.NME_assets_window_border_png);
			type.set ("assets/window_border.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/window_corner.png", nme.NME_assets_window_corner_png);
			type.set ("assets/window_corner.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_assets_about_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_bounce_mp3 extends flash.media.Sound { }
class NME_assets_cancel_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_cancel_inv_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_checkmark_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_chicago_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_desktop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fail01_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fail02_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_tiny_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_instructions_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lose_mp3 extends flash.media.Sound { }
class NME_assets_lose_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_matchpoint_mp3 extends flash.media.Sound { }
class NME_assets_miss_mp3 extends flash.media.Sound { }
class NME_assets_ok_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ok_inv_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_pixchicago_ttf extends flash.text.Font { }
class NME_assets_pixchicago_e_ttf extends flash.text.Font { }
class NME_assets_pixchicago_e2_ttf extends flash.text.Font { }
class NME_assets_scoreboard_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_scorewarning_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_septagon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_setendscore_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_splash_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_start_mp3 extends flash.media.Sound { }
class NME_assets_win_mp3 extends flash.media.Sound { }
class NME_assets_win_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_window_border_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_window_corner_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
