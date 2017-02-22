package tle
{
	import starling.events.EnterFrameEvent;
	import tle.display.TLESprite;
	
	public class TLEGame extends TLESprite
	{
		public function TLEGame()
		{
		
		}
		
		override protected function onAddedToStage():void
		{
			super.onRemovedFromStage();
			
			setupTextures();
			setupDirector();
			setupScene();
			
			setupLoop();
		}
		
		override protected function onRemovedFromStage():void
		{
			super.onRemovedFromStage();
			
			disposeLoop();
			
			disposeScene();
			disposeDirector();
			disposeTextures();
		}
		
		//textures (virtual function)
		protected function setupTextures():void
		{
		}
		
		protected function disposeTextures():void
		{
		}
		
		//director
		protected function setupDirector():void
		{
			TLEDirector.instance.scenesContainer = this;
		}
		
		protected function disposeDirector():void
		{
			TLEDirector.instance.scenesContainer = null;
		}
		
		//first screen (virtual function)
		protected function setupScene():void
		{
		}
		
		protected function disposeScene():void
		{
		}
		
		//sets loop cycle
		protected function setupLoop():void
		{
			addEventListener(EnterFrameEvent.ENTER_FRAME, loop);
		}
		
		protected function disposeLoop():void
		{
			removeEventListener(EnterFrameEvent.ENTER_FRAME, loop);
		}
		
		protected function loop(e:EnterFrameEvent):void
		{
			TLEDirector.instance.passedTime = e.passedTime;
			
			if (!TLEDirector.instance.paused)
			{
				TLEDirector.instance.actualScene.checkCollisions();
				TLEDirector.instance.actualScene.update();
				TLEDirector.instance.actualScene.updateEntities();
				TLEDirector.instance.actualScene.renderEntities();
			}
		}
	}
}