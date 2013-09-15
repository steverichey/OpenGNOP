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
			
			path.set ("assets/gnop.svg", "assets/gnop.svg");
			type.set ("assets/gnop.svg", Reflect.field (AssetType, "text".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}



