package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new Map <String, Dynamic> ();
	public static var library = new Map <String, LibraryType> ();
	public static var path = new Map <String, String> ();
	public static var type = new Map <String, AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			path.set ("images/about.png", "images/about.png");
			type.set ("images/about.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/cancel.png", "images/cancel.png");
			type.set ("images/cancel.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/cancel_inv.png", "images/cancel_inv.png");
			type.set ("images/cancel_inv.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/checkmark.png", "images/checkmark.png");
			type.set ("images/checkmark.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/desktop.png", "images/desktop.png");
			type.set ("images/desktop.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/fail01.png", "images/fail01.png");
			type.set ("images/fail01.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/fail02.png", "images/fail02.png");
			type.set ("images/fail02.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/font.png", "images/font.png");
			type.set ("images/font.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/icon.png", "images/icon.png");
			type.set ("images/icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/icon_tiny.png", "images/icon_tiny.png");
			type.set ("images/icon_tiny.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/instructions.png", "images/instructions.png");
			type.set ("images/instructions.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/lose.png", "images/lose.png");
			type.set ("images/lose.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/ok.png", "images/ok.png");
			type.set ("images/ok.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/ok_inv.png", "images/ok_inv.png");
			type.set ("images/ok_inv.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/scoreboard.png", "images/scoreboard.png");
			type.set ("images/scoreboard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/scorewarning.png", "images/scorewarning.png");
			type.set ("images/scorewarning.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/septagon.png", "images/septagon.png");
			type.set ("images/septagon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/setendscore.png", "images/setendscore.png");
			type.set ("images/setendscore.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/splash.png", "images/splash.png");
			type.set ("images/splash.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("images/win.png", "images/win.png");
			type.set ("images/win.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("sounds/bounce.mp3", "sounds/bounce.mp3");
			type.set ("sounds/bounce.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("sounds/lose.mp3", "sounds/lose.mp3");
			type.set ("sounds/lose.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("sounds/matchpoint.mp3", "sounds/matchpoint.mp3");
			type.set ("sounds/matchpoint.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("sounds/miss.mp3", "sounds/miss.mp3");
			type.set ("sounds/miss.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("sounds/start.mp3", "sounds/start.mp3");
			type.set ("sounds/start.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("sounds/win.mp3", "sounds/win.mp3");
			type.set ("sounds/win.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}




























