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
	public class WindowButtonBack extends Sprite
	{
		public function WindowButtonBack() 
		{
			var iButtonCancel:Bitmap;
			if (GameOptions.RusEng) {
				iButtonCancel = new GameGlobal.ImageButtonCancelRus();
				iButtonCancel.smoothing = true;
				iButtonCancel.scaleX -= 0.5;
				iButtonCancel.scaleY -= 0.5;
				this.addChild(iButtonCancel);
			}else {
				iButtonCancel = new GameGlobal.ImageButtonCancelEng();
				iButtonCancel.smoothing = true;
				iButtonCancel.scaleX -= 0.5;
				iButtonCancel.scaleY -= 0.5;
				this.addChild(iButtonCancel);
			}
			this.x = 250; this.y = 270;
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundClick(); // звук
			if(GameGlobal.actionUnit != null) GameGlobal.backUnitsInPanel();
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