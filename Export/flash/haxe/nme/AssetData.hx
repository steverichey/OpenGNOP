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
			className.set ("assets/cancel.png", nme.NME_assets_cancel_png);
			type.set ("assets/cancel.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/cancel_inv.png", nme.NME_assets_cancel_inv_png);
			type.set ("assets/cancel_inv.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/checkmark.png", nme.NME_assets_checkmark_png);
			type.set ("assets/checkmark.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/desktop.png", nme.NME_assets_desktop_png);
			type.set ("assets/desktop.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/fail01.png", nme.NME_assets_fail01_png);
			type.set ("assets/fail01.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/fail02.png", nme.NME_assets_fail02_png);
			type.set ("assets/fail02.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/GNOP_Bounce.mp3", nme.NME_assets_gnop_bounce_mp3);
			type.set ("assets/GNOP_Bounce.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/GNOP_Lose.mp3", nme.NME_assets_gnop_lose_mp3);
			type.set ("assets/GNOP_Lose.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/GNOP_MatchPoint.mp3", nme.NME_assets_gnop_matchpoint_mp3);
			type.set ("assets/GNOP_MatchPoint.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/GNOP_Miss.mp3", nme.NME_assets_gnop_miss_mp3);
			type.set ("assets/GNOP_Miss.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/GNOP_Start.mp3", nme.NME_assets_gnop_start_mp3);
			type.set ("assets/GNOP_Start.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/GNOP_Win.mp3", nme.NME_assets_gnop_win_mp3);
			type.set ("assets/GNOP_Win.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/icon.png", nme.NME_assets_icon_png);
			type.set ("assets/icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/instructions.png", nme.NME_assets_instructions_png);
			type.set ("assets/instructions.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/lose_fg.png", nme.NME_assets_lose_fg_png);
			type.set ("assets/lose_fg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/ok.png", nme.NME_assets_ok_png);
			type.set ("assets/ok.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/ok_fg.png", nme.NME_assets_ok_fg_png);
			type.set ("assets/ok_fg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/play_board.png", nme.NME_assets_play_board_png);
			type.set ("assets/play_board.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/play_border_1px.png", nme.NME_assets_play_border_1px_png);
			type.set ("assets/play_border_1px.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/play_corner.png", nme.NME_assets_play_corner_png);
			type.set ("assets/play_corner.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/scorewarning.png", nme.NME_assets_scorewarning_png);
			type.set ("assets/scorewarning.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/septagon.png", nme.NME_assets_septagon_png);
			type.set ("assets/septagon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/setendscore.png", nme.NME_assets_setendscore_png);
			type.set ("assets/setendscore.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/splash_fg.png", nme.NME_assets_splash_fg_png);
			type.set ("assets/splash_fg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/tiny_icon.png", nme.NME_assets_tiny_icon_png);
			type.set ("assets/tiny_icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/win_fg.png", nme.NME_assets_win_fg_png);
			type.set ("assets/win_fg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_assets_about_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_cancel_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_cancel_inv_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_checkmark_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_desktop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fail01_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fail02_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_gnop_bounce_mp3 extends flash.media.Sound { }
class NME_assets_gnop_lose_mp3 extends flash.media.Sound { }
class NME_assets_gnop_matchpoint_mp3 extends flash.media.Sound { }
class NME_assets_gnop_miss_mp3 extends flash.media.Sound { }
class NME_assets_gnop_start_mp3 extends flash.media.Sound { }
class NME_assets_gnop_win_mp3 extends flash.media.Sound { }
class NME_assets_icon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_instructions_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_lose_fg_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ok_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ok_fg_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_play_board_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_play_border_1px_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_play_corner_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_scorewarning_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_septagon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_setendscore_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_splash_fg_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_tiny_icon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_win_fg_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
