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
	public class ButtonNewGame extends Sprite
	{
		
		public function ButtonNewGame() 
		{
			
			this.x = 200; this.y = 80;
			if (GameOptions.RusEng) {
				GameGlobal.iButtonNewGameRus.smoothing = true;
				this.addChild(GameGlobal.iButtonNewGameRus);
			}else {
				GameGlobal.iButtonNewGameEng.smoothing = true;
				this.addChild(GameGlobal.iButtonNewGameEng);
			}
			this.scaleX -= 0.2;
			this.scaleY -= 0.2;
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundClick(); // звук
			GameGlobal.restartGame();
		}
		private function onMouseOutButton(e:MouseEvent):void
		{
			this.scaleX -= 0.1;
			this.scaleY -= 0.1;
			this.x += 10.0;
			this.y += 5.0;
			Mouse.cursor = MouseCursor.AUTO;
		}
		private function onMouseOverButton(e:MouseEvent):void
		{
			this.scaleX += 0.1;
			this.scaleY += 0.1;
			this.x -= 10.0;
			this.y -= 5.0;
			Mouse.cursor = MouseCursor.BUTTON;
		}
	}

}