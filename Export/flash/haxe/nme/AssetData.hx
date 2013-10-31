package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("images/about.png", nme.NME_images_about_png);
			type.set ("images/about.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/cancel.png", nme.NME_images_cancel_png);
			type.set ("images/cancel.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/cancel_inv.png", nme.NME_images_cancel_inv_png);
			type.set ("images/cancel_inv.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/checkmark.png", nme.NME_images_checkmark_png);
			type.set ("images/checkmark.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/desktop.png", nme.NME_images_desktop_png);
			type.set ("images/desktop.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/fail01.png", nme.NME_images_fail01_png);
			type.set ("images/fail01.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/fail02.png", nme.NME_images_fail02_png);
			type.set ("images/fail02.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/font.png", nme.NME_images_font_png);
			type.set ("images/font.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/icon.png", nme.NME_images_icon_png);
			type.set ("images/icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/icon_tiny.png", nme.NME_images_icon_tiny_png);
			type.set ("images/icon_tiny.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/instructions.png", nme.NME_images_instructions_png);
			type.set ("images/instructions.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/lose.png", nme.NME_images_lose_png);
			type.set ("images/lose.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/ok.png", nme.NME_images_ok_png);
			type.set ("images/ok.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/ok_inv.png", nme.NME_images_ok_inv_png);
			type.set ("images/ok_inv.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/scoreboard.png", nme.NME_images_scoreboard_png);
			type.set ("images/scoreboard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/scorewarning.png", nme.NME_images_scorewarning_png);
			type.set ("images/scorewarning.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/septagon.png", nme.NME_images_septagon_png);
			type.set ("images/septagon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/setendscore.png", nme.NME_images_setendscore_png);
			type.set ("images/setendscore.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/splash.png", nme.NME_images_splash_png);
			type.set ("images/splash.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("images/win.png", nme.NME_images_win_png);
			type.set ("images/win.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("sounds/bounce.mp3", nme.NME_sounds_bounce_mp3);
			type.set ("sounds/bounce.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("sounds/lose.mp3", nme.NME_sounds_lose_mp3);
			type.set ("sounds/lose.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("sounds/lose.ogg", nme.NME_sounds_lose_ogg);
			type.set ("sounds/lose.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			className.set ("sounds/matchpoint.mp3", nme.NME_sounds_matchpoint_mp3);
			type.set ("sounds/matchpoint.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("sounds/matchpoint.ogg", nme.NME_sounds_matchpoint_ogg);
			type.set ("sounds/matchpoint.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			className.set ("sounds/paddle_land.mp3", nme.NME_sounds_paddle_land_mp3);
			type.set ("sounds/paddle_land.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("sounds/paddle_land.ogg", nme.NME_sounds_paddle_land_ogg);
			type.set ("sounds/paddle_land.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			className.set ("sounds/start.mp3", nme.NME_sounds_start_mp3);
			type.set ("sounds/start.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("sounds/win.mp3", nme.NME_sounds_win_mp3);
			type.set ("sounds/win.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("sounds/win.ogg", nme.NME_sounds_win_ogg);
			type.set ("sounds/win.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_images_about_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_cancel_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_cancel_inv_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_checkmark_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_desktop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_fail01_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_fail02_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_font_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_icon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_icon_tiny_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_instructions_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_lose_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_ok_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_ok_inv_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_scoreboard_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_scorewarning_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_septagon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_setendscore_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_splash_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_images_win_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_sounds_bounce_mp3 extends flash.media.Sound { }
class NME_sounds_lose_mp3 extends flash.media.Sound { }
class NME_sounds_lose_ogg extends flash.media.Sound { }
class NME_sounds_matchpoint_mp3 extends flash.media.Sound { }
class NME_sounds_matchpoint_ogg extends flash.media.Sound { }
class NME_sounds_paddle_land_mp3 extends flash.media.Sound { }
class NME_sounds_paddle_land_ogg extends flash.media.Sound { }
class NME_sounds_start_mp3 extends flash.media.Sound { }
class NME_sounds_win_mp3 extends flash.media.Sound { }
class NME_sounds_win_ogg extends flash.media.Sound { }
