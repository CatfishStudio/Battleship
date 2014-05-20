package Battleship 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class WindowRadioButton extends Sprite
	{
		private var _bUP:Bitmap = new GameGlobal.ImageButtonUP();
		private var _bDOWN:Bitmap = new GameGlobal.ImageButtonDOWN();
		
		public function WindowRadioButton(tick:Boolean) 
		{
			this.addChild(_bUP);
			this.addChild(_bDOWN);
			if (tick) {
				_bUP.visible = true;
				_bDOWN.visible = false;
			} else {
				_bUP.visible = false;
				_bDOWN.visible = true;
			}
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundClick(); // звук
			if (_bUP.visible == true) {
				_bUP.visible = false;
				_bDOWN.visible = true;
			} else {
				_bUP.visible = true;
				_bDOWN.visible = false;
			}
			dispatchEvent(new Event(Event.CHANGE));
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