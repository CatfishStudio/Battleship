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
	public class WindowButtonTheBattle extends Sprite
	{
		
		public function WindowButtonTheBattle(x:int, y:int) 
		{
			var iButtonTheBattle:Bitmap;
			if (GameOptions.RusEng) {
				iButtonTheBattle = new GameGlobal.ImageButtonTheBattleRus();
				iButtonTheBattle.smoothing = true;
				iButtonTheBattle.scaleX -= 0.5;
				iButtonTheBattle.scaleY -= 0.5;
				this.addChild(iButtonTheBattle);
			}else {
				iButtonTheBattle = new GameGlobal.ImageButtonTheBattleEng();
				iButtonTheBattle.smoothing = true;
				iButtonTheBattle.scaleX -= 0.5;
				iButtonTheBattle.scaleY -= 0.5;
				this.addChild(iButtonTheBattle);
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
			// закрываем панель и окно.
			if (GameGlobal.Level.getChildByName("WindowStartBattle") != null) GameGlobal.Level.removeChild(GameGlobal.Level.getChildByName("WindowStartBattle"));
			if (GameGlobal.Level.getChildByName("PanelShips") != null) GameGlobal.Level.removeChild(GameGlobal.Level.getChildByName("PanelShips"));
			// отключаем активный юнит.
			GameGlobal.actionUnit = null;
			// делаем ячейки пользователя не доступными.
			//for (var i:int = 0; i < 10; i++) {
			//	for (var j:int = 0; j < 10; j++) {
			//		GameGlobal.userField[i][j].activeCell = false;
			//	}
			//}
			// установка кораблей противника -----
			GameAI.SetShipsPC(GameGlobal.pcField);
			//------------------------------------
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