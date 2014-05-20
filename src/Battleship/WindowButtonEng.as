package Battleship 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class WindowButtonEng extends Sprite
	{
		
		public function WindowButtonEng() 
		{
			GameGlobal.iButtonEng.smoothing = true;
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			this.addChild(GameGlobal.iButtonEng);
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundClick(); // звук
			GameOptions.RusEng = false;
		}
		private function onMouseOutButton(e:MouseEvent):void
		{
			this.scaleX -= 0.1;
			this.scaleY -= 0.1;
			this.x += 0.1;
			this.y += 0.1;
			Mouse.cursor = MouseCursor.AUTO;
		}
		private function onMouseOverButton(e:MouseEvent):void
		{
			this.scaleX += 0.1;
			this.scaleY += 0.1;
			this.x -= 0.1;
			this.y -= 0.1;
			Mouse.cursor = MouseCursor.BUTTON;
		}
	}

}