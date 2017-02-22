package tle.assets
{
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	public class TLETexturesManager
	{
		//singleton
		private static var _instance:TLETexturesManager
		
		public static function get instance():TLETexturesManager
		{
			if (!_instance)
				_instance = new TLETexturesManager();
			
			return _instance;
		}
		
		//end
		
		//constructor
		public function TLETexturesManager()
		{
			_texturesDictionary = new Dictionary();
		}
		
		//textures
		private var _texturesDictionary:Dictionary;
		
		public function getTexture(name:String):Texture
		{
			return _texturesDictionary[name];
		}
		
		public function addTexture(name:String, texture:Texture):void
		{
			_texturesDictionary[name] = texture;
		}
		
		public function removeTexture(name:String):void
		{
			_texturesDictionary[name] = null;
		}
	
	}
}