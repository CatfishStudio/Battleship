package Battleship 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class WindowButtonReset extends Sprite
	{

		public function WindowButtonReset(x:int, y:int) 
		{
			var iButtonReset:Bitmap;
			if (GameOptions.RusEng) {
				iButtonReset = new GameGlobal.ImageButtonResetRus();
				iButtonReset.smoothing = true;
				iButtonReset.scaleX -= 0.5;
				iButtonReset.scaleY -= 0.5;
				this.addChild(iButtonReset);
			}else {
				iButtonReset = new GameGlobal.ImageButtonResetEng();
				iButtonReset.smoothing = true;
				iButtonReset.scaleX -= 0.5;
				iButtonReset.scaleY -= 0.5;
				this.addChild(iButtonReset);
			}
			this.x = x; this.y = y;
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundClick(); // звук
			GameGlobal.resetUnitsInPanel();
		}
		private function onMouseOutButton(e:MouseEvent):void
		{
			this.scaleX -= 0.1;	this.scaleY -= 0.1;
			this.x += 0.1; this.y += 0.1;
			Mouse.cursor = MouseCursor.AUTO;
		}
		private function onMouseOverButton(e:MouseEvent):void
		{
			this.scaleX += 0.1;	this.scaleY += 0.1;
			this.x -= 0.1;	this.y -= 0.1;
			Mouse.cursor = MouseCursor.BUTTON;
		}
	}

}