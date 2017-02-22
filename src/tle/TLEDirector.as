package tle
{
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	import tle.scenes.TLEScene;
	
	public class TLEDirector
	{
		//singleton
		private static var _instance:TLEDirector
		
		public static function get instance():TLEDirector
		{
			if (!_instance)
				_instance = new TLEDirector();
			
			return _instance;
		}
		//end
		
		//scenes container 
		private var _scenesContainer:Sprite;
		
		public function get scenesContainer():Sprite
		{
			return _scenesContainer;
		}
		
		public function set scenesContainer(value:Sprite):void
		{
			//removes the actualScene from the actual scenesContainer
			if (_scenesContainer && _actualScene)
				_scenesContainer.removeChild(_actualScene);
			
			//sets new scenesContainer
			_scenesContainer = value;
			
			//adds the actualScene to the new scenesContainer
			if (_scenesContainer && _actualScene)
				_scenesContainer.addChild(_actualScene);
		}
		
		//scenes
		private var _actualScene:TLEScene;
		
		public function changeToScene(scene:TLEScene):void
		{
			//checks if scenesContainer is defined
			if (!_scenesContainer)
				throw new Error("scenesContainer not defined");
			
			//checks for a current presented scene, if exists - removes it from stage and disposes it
			if (_actualScene)
			{
				_scenesContainer.removeChild(_actualScene);
				_actualScene.dispose();
			}
			
			//sets new scene as actual scene and shows it
			_actualScene = scene;
			
			_scenesContainer.addChild(_actualScene);
		}
		public function get actualScene():TLEScene
		{
			return _actualScene;
		}
		
		//resolution
		protected var _resolution:Point;
		
		public function get resolution():Point
		{
			return _resolution;
		}
		
		public function set resolution(value:Point):void
		{
			_resolution = value;
			
			Starling.current.stage.stageWidth = _resolution.x;
			Starling.current.stage.stageHeight = _resolution.y;
		}
		
		public function get screenWidthScaleRatio():Number
		{
			return Starling.current.nativeStage.stageWidth / Starling.current.stage.stageWidth;
		}
		
		public function get screenHeightScaleRatio():Number
		{
			return Starling.current.nativeStage.stageHeight / Starling.current.stage.stageHeight;
		}
		
		//time
		public var paused:Boolean = false;
		public var passedTime:Number = 0;
	}
}