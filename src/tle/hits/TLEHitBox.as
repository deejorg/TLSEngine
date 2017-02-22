package tle.hits
{
	import flash.geom.Rectangle;
	
	public class TLEHitBox
	{
		
		public function TLEHitBox(rectangle:Rectangle = null)
		{
			this.rectangle = rectangle;
		}
		
		//rectangle
		public var rectangle:Rectangle;
		
		//collide methods
		public function collide(hitbox:TLEHitBox):Boolean
		{
			return rectangle.intersects(hitbox.rectangle);
		}
	}

}