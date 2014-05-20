package Battleship 
{
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Boom extends Sprite
	{
		private var imageBD:BitmapData = new BitmapData(355, 400, true, 0x000000000000); // полная картинка
		private var canvasBD:BitmapData = new BitmapData(71, 100, true, 0x000000000000); // размер выбраной картинки
		private var image:Bitmap;
		private var boomImage:Bitmap;
		
		private var rect:Rectangle = new Rectangle(0, 0, 355, 400); //исходный размер
		private var pt:Point = new Point(0, 0); // начальная точка
		
		
		public function Boom(imageBoom:Class) 
		{
			
			image = new imageBoom();
			imageBD.draw(image); // загружаем картинку
			rect.x = 0;
			canvasBD.copyPixels(imageBD, rect, pt);
			boomImage = new Bitmap(canvasBD);
			this.addChild(boomImage);
			this.addEventListener(Event.ENTER_FRAME, animationLoop);
		}
		
		/* Однократное воспроизведение анимации */
		private function animationLoop(e:Event):void
		{
			if (rect.x == 284 && rect.y == 400) {
				this.dispatchEvent(new Event(Event.CLOSE)); // возвращаем событие закрытия анимации для её удаления.
				this.removeEventListener(Event.ENTER_FRAME, animationLoop); // отключаем событие
			}
			
			rect.x += 71;
			if (rect.x == 355) {
				rect.y += 100;
				rect.x = 0;
			}
			canvasBD.copyPixels(imageBD, rect, pt);
			boomImage = new Bitmap(canvasBD);
		}
	}

}