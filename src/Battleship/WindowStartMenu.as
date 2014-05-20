package Battleship 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class WindowStartMenu extends Sprite
	{
		private var _wButtonStart:WindowButtonStart = new WindowButtonStart();
		private var _wButtonRus:WindowButtonRus = new WindowButtonRus();
		private var _wButtonEng:WindowButtonEng = new WindowButtonEng();
		private var _position:int;
		
		public function WindowStartMenu() 
		{
			//координаты окна по умолчанию
			this.x = 0; this.y = 0;
			_position = 25;
			//Перекрывающая область.
			this.graphics.beginFill(0x000000, 0.5);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			//картинка окнна
			GameGlobal.iStartMenu.x = 130;
			GameGlobal.iStartMenu.y = -600;
			this.addChild(GameGlobal.iStartMenu);
			this.addEventListener(Event.ENTER_FRAME, onLoop);
			//кнопка Старт
			_wButtonStart.addEventListener(Event.CHANGE, onStart);
			_wButtonStart.x = 335; _wButtonStart.y = -240;//360;
			this.addChild(_wButtonStart);
			//кнопка рус
			_wButtonRus.x = 350; _wButtonRus.y =  -150;//450;
			this.addChild(_wButtonRus)
			//кнопка Инг
			_wButtonEng.x = 420; _wButtonEng.y =  -150;//450;
			this.addChild(_wButtonEng)
		}
		
		/*Нажата кнопка начала игры */
		private function onStart(e:Event):void
		{
			_position = 600;
		}
		
		/*Функция анимации */
		private function onLoop(e:Event):void 
		{
			if (GameGlobal.iStartMenu.y < _position) {
				GameGlobal.iStartMenu.y += 40.0;
				_wButtonStart.y += 40.0;
				_wButtonRus.y += 40.0;
				_wButtonEng.y += 40.0;
			}else {
				_wButtonStart.y = 360;
				_wButtonRus.y =  450;
				_wButtonEng.y =  450;
				GameGlobal.iStartMenu.y = _position;
				if (GameGlobal.iStartMenu.y == 600) {
					dispatchEvent(new Event(Event.CHANGE)); // возвращаем событие
					this.removeEventListener(Event.ENTER_FRAME, onLoop); //отключаем событие анимации
				}
			}
			/*Локализация*/
			if (GameOptions.RusEng) {
				_wButtonStart.getChildAt(0).visible = false;	//eng
				_wButtonStart.getChildAt(1).visible = true;		//rus
			}else {
				_wButtonStart.getChildAt(1).visible = false;	//rus
				_wButtonStart.getChildAt(0).visible = true;		//eng
			}
		}
	}

}