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
	public class WindowButtonRotat extends Sprite
	{
		
		public function WindowButtonRotat() 
		{
			var iButtonRotat:Bitmap;
			if (GameOptions.RusEng) {
				iButtonRotat = new GameGlobal.ImageButtonRotatRus();
				iButtonRotat.smoothing = true;
				iButtonRotat.scaleX -= 0.5;
				iButtonRotat.scaleY -= 0.5;
				this.addChild(iButtonRotat);
			}else {
				iButtonRotat = new GameGlobal.ImageButtonRotatEng();
				iButtonRotat.smoothing = true;
				iButtonRotat.scaleX -= 0.5;
				iButtonRotat.scaleY -= 0.5;
				
				this.addChild(iButtonRotat);
			}
			this.x = 50; this.y = 270;
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundClick(); // звук
			if (GameGlobal.actionUnit != null) {
				if (GameGlobal.actionUnit.rotation == 0) {
					GameGlobal.actionUnit.rotation = -90;
				}else {
					GameGlobal.actionUnit.rotation = 0;
				}
			}
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