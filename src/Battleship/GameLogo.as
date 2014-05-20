package Battleship 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class GameLogo extends Sprite
	{
		
		public function GameLogo(x:int, y:int) 
		{
			this.x = x; this.y = y;
			this.addChild(GameGlobal.iLogo);
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			var request:URLRequest = new URLRequest('https://vk.com/club62618339');
			navigateToURL(request);
		}
		private function onMouseOutButton(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		private function onMouseOverButton(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
	}

}