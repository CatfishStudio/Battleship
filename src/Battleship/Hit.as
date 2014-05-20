package Battleship 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Hit extends Sprite
	{
		private var imageBD:BitmapData = new BitmapData(180, 30, true, 0x000000000000); // полная картинка
		private var canvasBD:BitmapData = new BitmapData(30, 30, true, 0x000000000000); // размер выбраной картинки
		private var image:Bitmap;
		private var hitImage:Bitmap;
		
		private var rect:Rectangle = new Rectangle(0, 0, 180, 30); //исходный размер
		private var pt:Point = new Point(0, 0); // начальная точка
		
		
		public function Hit(imageHit:Class) 
		{
			image = new imageHit();
			imageBD.draw(image); // загружаем картинку
			rect.x = -5;
			canvasBD.copyPixels(imageBD, rect, pt);
			
			hitImage = new Bitmap(canvasBD);
			this.addChild(hitImage);
			this.addEventListener(Event.ENTER_FRAME, animationLoop);
			// Звук попадения
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundHit();
		}
		
		private function animationLoop(e:Event):void {
			// -5, 20, 50, 85, 120, 150
			if (rect.x == -5) {
				rect.x = 20;
			}else {
				if (rect.x == 20) {
					rect.x = 50;
				}else {
					if (rect.x == 50) {
						rect.x = 85;
					}else {
						if (rect.x == 85) {
							rect.x = 120;
						}else {
							if (rect.x == 120) {
								rect.x = 150;
							}else {
								if (rect.x == 150) {
									rect.x = -5;
								}
							}
						}
					}
				}
			}
			canvasBD.copyPixels(imageBD, rect, pt);
			hitImage = new Bitmap(canvasBD);
		}
	}

}