package tle.display
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class TLESprite extends Sprite
	{
		public function TLESprite()
		{
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		private function _onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
			
			onAddedToStage();
		}
		
		private function _onRemovedFromStage():void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			onRemovedFromStage();
		}
		
		//virtual methods
		protected function onAddedToStage():void
		{
		}
		
		protected function onRemovedFromStage():void
		{
		}
	}
}