package Battleship
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			/* Запуск игры */
			GameGlobal.Level = new GameLevel();
			this.addChild(GameGlobal.Level);
			GameGlobal.MainSprite = this;
		}
		
		
	}
	
}