package tle.cameras
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import tle.scenes.TLEScene;
	
	public class TLECamera
	{
		public function TLECamera(width:Number = 100, height:Number = 100)
		{
			_viewPort = new Rectangle(0, 0, width, height);
		}
		
		//viewport properties
		protected var _viewPort:Rectangle;
		
		public function get leftX():Number
		{
			return _viewPort.x;
		}
		
		public function set leftX(value:Number):void
		{
			_viewPort.x = value;
			
			_validateLimits();
			_updateScene();
		}
		
		public function get centerX():Number
		{
			return _viewPort.x + _viewPort.width / 2;
		}
		
		public function set centerX(value:Number):void
		{
			_viewPort.x = -_viewPort.width / 2 + value;
			
			_validateLimits();
			_updateScene();
		}
		
		public function get rightX():Number
		{
			return _viewPort.right;
		}
		
		public function set rightX(value:Number):void
		{
			_viewPort.x = -_viewPort.width + value;
			
			_validateLimits();
			_updateScene();
		}
		
		public function get topY():Number
		{
			return _viewPort.y;
		}
		
		public function set topY(value:Number):void
		{
			_viewPort.y = value;
			
			_validateLimits();
			_updateScene();
		}
		
		public function get centerY():Number
		{
			return _viewPort.y + _viewPort.height / 2;
		}
		
		public function set centerY(value:Number):void
		{
			_viewPort.y = -_viewPort.height / 2 + value;
			
			_validateLimits();
			_updateScene();
		}
		
		public function get bottomY():Number
		{
			return _viewPort.bottom;
		}
		
		public function set bottomY(value:Number):void
		{
			_viewPort.y = -_viewPort.height + value;
			
			_validateLimits();
			_updateScene();
		}
		
		//limits
		protected var _limits:Rectangle;
		
		public function get limits():Rectangle
		{
			return _limits;
		}
		
		public function set limits(value:Rectangle):void
		{
			_limits = value;
			
			_validateLimits();
			_updateScene();
		}
		
		protected function _validateLimits():void
		{
			_viewPort.x = Math.max(_viewPort.x, _limits.x);
			_viewPort.x = Math.min(_viewPort.x, _limits.right - _viewPort.width);
			
			_viewPort.y = Math.max(_viewPort.y, _limits.y);
			_viewPort.y = Math.min(_viewPort.y, _limits.bottom - _viewPort.height);
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
			
			if (_scene && _scene.gameLayer)
				_updateScene();
		}
		
		protected function _updateScene():void
		{
			_scene.gameLayer.x = -_viewPort.x;
			_scene.gameLayer.y = -_viewPort.y;
		}
	}
}