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
	public class Unit extends Sprite
	{
		public var meSet:Boolean = false; //флаг установленного корабля на поле.
		public var type:uint; // тип юнита: 1-но палубный, 2-х палубный, 3-х палубный, 4-х палубный
		/* Массив выбранных ячеек во время установки корабля на поле */
		public var selectCellArray:Array = []; // корабль пренадлежит ячейкам поля
		/* Место в массиве юнитов */
		public var index:int; // соответствует массивам: units и unitsArray
		/* картинки кораблей */
		private var _image1:Bitmap; // целый корабль.
		private var _image2:Bitmap; // разрушенный корабль.
		/* Анимация взрыва */
		private var boom:Boom;
		/* Флаг полного уничтожения данного юнита*/
		public var unitDestroy:Boolean = false; // по умолчанию корабль не уничтожен.
		
		public function Unit(Image1:Class, Image2:Class) 
		{ 
			_image1 = new Image1();
			_image2 = new Image2();
			_image1.visible = true;
			this.addChild(_image1);
			_image2.visible = false;
			this.addChild(_image2);
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
		
		/* Картинка меняется на разбитый корабль*/
		public function UnitDestroy():void
		{
			_image1.visible = false;
			_image2.visible = true;
			unitDestroy = true;
		}
		
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			if(meSet == false){ //если корабль еще не установлен на поле
				if(GameGlobal.actionUnit != null) GameGlobal.backUnitsInPanel();
				GameGlobal.actionUnit = this;
				GameGlobal.actionUnit.x = e.stageX + 5; 
				GameGlobal.actionUnit.y = e.stageY + 5;
			}
		}
		private function onMouseOutButton(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		private function onMouseOverButton(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
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
	}

}