package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("assets/desktop.png", nme.NME_assets_desktop_png);
			type.set ("assets/desktop.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon.png", nme.NME_assets_icon_png);
			type.set ("assets/icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/septagon.png", nme.NME_assets_septagon_png);
			type.set ("assets/septagon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_assets_desktop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_septagon_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
