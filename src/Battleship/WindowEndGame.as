package Battleship 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class WindowEndGame extends Sprite
	{
		private var _position:int;
		private var _label:GameLabel;
		private var _wButtonOK:WindowButtonOK = new WindowButtonOK();
		
		public function WindowEndGame(textMessage:String) 
		{
			Mouse.cursor = MouseCursor.AUTO;
			//координаты окна по умолчанию
			this.x = 0; this.y = 0;
			_position = 100;
			//Перекрывающая область.
			this.graphics.beginFill(0x000000, 0.5);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			//картинка окнна
			GameGlobal.iEndGame.x = 230;
			GameGlobal.iEndGame.y = -600;
			this.addChild(GameGlobal.iEndGame);
			this.addEventListener(Event.ENTER_FRAME, onLoop);
			// вывод сообщения
			_label = new GameLabel(260, 250, 350, 70, "Aria", 42, 0x0000A3, textMessage);
			_label.y = -460;
			this.addChild(_label);
			// кнопка ОК
			_wButtonOK.addEventListener(Event.CHANGE, onOK);
			_wButtonOK.x = 340; _wButtonOK.y = -385;
			this.addChild(_wButtonOK);
			
		}
		
		/*Нажата кнопка начала игры */
		private function onOK(e:Event):void
		{
			_position = 600;
		}
		
		/*Функция анимации */
		private function onLoop(e:Event):void 
		{
			if (GameGlobal.iEndGame.y < _position) {
				GameGlobal.iEndGame.y += 40.0;
				_label.y += 40.0;
				_wButtonOK.y += 40.0;
			}else {
				_label.y = 280;
				_wButtonOK.y = 340;
				GameGlobal.iEndGame.y = _position;
				if (GameGlobal.iEndGame.y == 600) {
					//dispatchEvent(new Event(Event.CLOSE)); // возвращаем событие
					GameGlobal.restartGame(); // перезапуск игры.
					this.removeEventListener(Event.ENTER_FRAME, onLoop); //отключаем событие анимации
				}
			}
			
		}
		
		
	}

}