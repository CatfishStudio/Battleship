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
	public class Unit2 extends Sprite
	{
		public var meSet:Boolean = false; //флаг установленного корабля на поле.
		public var type:uint; // тип юнита: 1-но палубный, 2-х палубный, 3-х палубный, 4-х палубный
		/* Массив выбранных ячеек во время установки корабля на поле */
		public var selectCellArray:Array = []; // корабль пренадлежит ячейкам поля
		/* Место в массиве юнитов */
		public var index:int; // соответствует массивам: unitsPC
		/* Анимация взрыва */
		private var boom:Boom;
		/* Флаг полного уничтожения данного юнита*/
		public var unitDestroy:Boolean = false; // по умолчанию корабль не уничтожен.
		
		public function Unit2(Image:Class) 
		{
			var _image:Bitmap = new Image();
			this.addChild(_image);
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/* Запуск снимации взрыва и прекращение ----------------------*/
		public function unitBoom():void
		{
			boom = new Boom(GameGlobal.ImageAnimationBoom);
			if(this.height == 32){
				boom.x = (this.width / 2) - 35;
				boom.y = (this.height / 2) - 50;
			}else {
				boom.x = (this.height / 2) - 50;
				boom.y = (this.width / 2) - 35;
			}
			
			boom.addEventListener(Event.CLOSE, onBoomClose);
			this.addChild(boom);
		}
		private function onBoomClose(e:Event):void
		{
			this.removeChild(boom); // удаление анимации
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
		
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