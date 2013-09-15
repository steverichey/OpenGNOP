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
			
			path.set ("assets/desktop.png", "assets/desktop.png");
			type.set ("assets/desktop.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/icon.png", "assets/icon.png");
			type.set ("assets/icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/septagon.png", "assets/septagon.png");
			type.set ("assets/septagon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}





