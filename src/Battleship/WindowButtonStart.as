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
	public class WindowButtonStart extends Sprite
	{
		
		public function WindowButtonStart() 
		{
			GameGlobal.iButtonStart.smoothing = true;
			GameGlobal.iButtonStartRus.smoothing = true;
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			
			this.addChild(GameGlobal.iButtonStart);
			this.addChild(GameGlobal.iButtonStartRus);
			if (GameOptions.RusEng){
				GameGlobal.iButtonStart.visible = false;
				GameGlobal.iButtonStartRus.visible = true;
			}else {
				GameGlobal.iButtonStart.visible = true;
				GameGlobal.iButtonStartRus.visible = false;
			}
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundClick(); // звук
			dispatchEvent(new Event(Event.CHANGE));
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