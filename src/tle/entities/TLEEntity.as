package tle.entities
{
	import nape.phys.Body;
	import starling.display.DisplayObject;
	import tle.display.TLESprite;
	import tle.hits.TLEHitBox;
	import tle.scenes.TLEScene;
	
	public class TLEEntity
	{
		public function TLEEntity()
		{
			_tags = new Vector.<String>();
			
			setup();
		}
		
		//lifecycle virtual functions
		protected function setup():void
		{
		
		}
		
		public function update():void
		{
		
		}
		
		public function render():void
		{
		
		}
		
		//scene
		protected var _scene:TLEScene;
		
		public function get scene():TLEScene
		{
			return _scene;
		}
		
		public function set scene(value:TLEScene):void
		{
			_scene = value;
		}
		
		//layer
		protected var _layer:TLESprite;
		
		public function get layer():TLESprite
		{
			return _layer;
		}
		
		public function set layer(value:TLESprite):void
		{
			//if _layer is null, defines _scene.gameLayer as default layer, or null if scene doesn't exists
			_layer = value ? value : (_scene ? _scene.gameLayer : null);
			
			if (_view)
				_layer.addChild(_view);
		}
		
		//type
		protected var _type:String;
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		//tags
		protected var _tags:Vector.<String>;
		
		public function get tags():Vector.<String>
		{
			return _tags;
		}
		
		public function addTag(tag:String):void
		{
			if (haveTag(tag))
				return;
			
			_tags.push(tag);
		}
		
		public function removeTag(tag:String):void
		{
			var tagIndex:int = _tags.indexOf(tag);
			
			if (tagIndex != -1)
			{
				_tags.splice(tagIndex, 1);
			}
		}
		
		public function haveTag(tag:String):Boolean
		{
			return _tags.indexOf(tag) != -1 ? true : false;
		}
		
		//display
		
		protected var _x:Number;
		protected var _y:Number;
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
			
			if (view)
				view.x = _x;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
			
			if (view)
				view.y = _y;
		}
		
		protected var _rotation:Number;
		
		public function get rotation():Number
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void
		{
			_rotation = value;
			
			if (view)
				view.rotation = _rotation;
		}
		
		//////components//////
		
		//view component
		protected var _view:DisplayObject;
		
		public function get view():DisplayObject
		{
			return _view;
		}
		
		public function set view(value:DisplayObject):void
		{
			//checks for current view, if exists removes it from _layer
			if (_view)
			{
				if (_layer)
					_layer.removeChild(_view);
				_view.dispose();
			}
			
			_view = value;
			
			if (_view && _layer)
				_layer.addChild(_view);
		}
		
		//hit component
		public var hitBox:TLEHitBox;
		
		//body component
		public var body:Body;
	}
}