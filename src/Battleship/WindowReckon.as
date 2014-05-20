package Battleship 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class WindowReckon extends Sprite
	{
		private var _iWinReckon:Bitmap = new GameGlobal.ImagePanelShips();
		private var _ButtonOK:WindowButtonOK = new WindowButtonOK();
		private var _nameWindow:GameLabel;
		private var _unit1:Bitmap;
		private var _unit1Destroy:int = 0;
		private var _unit2:Bitmap;
		private var _unit2Destroy:int = 0;
		private var _unit3:Bitmap;
		private var _unit3Destroy:int = 0;
		private var _unit4:Bitmap;
		private var _unit4Destroy:int = 0;
		//private var _unit5:Bitmap;
		
		public function WindowReckon(units:Array) 
		{
			Mouse.cursor = MouseCursor.AUTO;
			//координаты окна по умолчанию
			this.x = 0; this.y = 0;
			//Перекрывающая область.
			this.graphics.beginFill(0x000000, 0.8);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			//картинка окна
			_iWinReckon.x = 230;
			_iWinReckon.y = 100;
			this.addChild(_iWinReckon);
			
			// Подпись окна
			if (GameOptions.RusEng) {
				_nameWindow = new GameLabel(350, 130, 300, 50, "Aria", 24, 0x0000A3, "Разведка:");
			}else {
				_nameWindow = new GameLabel(350, 130, 300, 50, "Aria", 24, 0x0000A3, "Scouting:");
			}
			this.addChild(_nameWindow);
			
			/* Отображение юнитов противника */
			_unit1 = new GameGlobal.ImageShip1();
			_unit1.x = 270; _unit1.y = 170;
			this.addChild(_unit1);
			for (var i:int = 0; i < units.length; i++)
			{
				if (units[i].type == 1 && units[i].unitDestroy) _unit1Destroy++;
			}
			if (GameOptions.RusEng) {
				this.addChild(new GameLabel(310, 175, 300, 50, "System", 16, 0x000000, "Торпедные катера: " + _unit1Destroy.toString() + " / 4"));
			}else {
				this.addChild(new GameLabel(310, 175, 300, 50, "System", 16, 0x000000, "Torpedo  boats: " + _unit1Destroy.toString()  + " / 4"));
			}
				
			_unit2 = new GameGlobal.ImageShip2();
			_unit2.x = 270; _unit2.y = 210;
			this.addChild(_unit2);
			for (var i:int = 0; i < units.length; i++)
			{
				if (units[i].type == 2 && units[i].unitDestroy) _unit2Destroy++;
			}
			if (GameOptions.RusEng) {
				this.addChild(new GameLabel(340, 215, 300, 50, "System", 16, 0x000000, "Эсминцы: " + _unit2Destroy.toString()  + " / 3"));
			}else {
				this.addChild(new GameLabel(340, 215, 300, 50, "System", 16, 0x000000, "Destroyers: " + _unit2Destroy.toString()  + " / 3"));	
			}
			
			_unit3 = new GameGlobal.ImageShip3();
			_unit3.x = 270; _unit3.y = 250;
			this.addChild(_unit3);
			for (var i:int = 0; i < units.length; i++)
			{
				if (units[i].type == 3 && units[i].unitDestroy) _unit3Destroy++;
			}
			if (GameOptions.RusEng) {
				this.addChild(new GameLabel(370, 255, 300, 50, "System", 16, 0x000000, "Линкоры: " + _unit3Destroy.toString() + " / 2"));
			}else {
				this.addChild(new GameLabel(370, 255, 300, 50, "System", 16, 0x000000, "Battleships: " + _unit3Destroy.toString()  + " / 2"));	
			}
				
			_unit4 = new GameGlobal.ImageShip4();
			_unit4.x = 270; _unit4.y = 300;
			this.addChild(_unit4);
			for (var i:int = 0; i < units.length; i++)
			{
				if (units[i].type == 4 && units[i].unitDestroy) _unit4Destroy++;
			}
			if (GameOptions.RusEng) {
				this.addChild(new GameLabel(400, 305, 300, 50, "System", 16, 0x000000, "Авианосец: " + _unit4Destroy.toString() + " / 1"));
			}else {
				this.addChild(new GameLabel(400, 305, 300, 50, "System", 16, 0x000000, "Aircraft carrier: " + _unit4Destroy.toString() + " / 1"));	
			}
				
			//_unit5 = new GameGlobal.ImageMine();
			
			/*-------------------------------*/
			
			//кнопка ОК
			_ButtonOK.x = 335; _ButtonOK.y = 350;
			_ButtonOK.addEventListener(Event.CHANGE, onClickOK);
			this.addChild(_ButtonOK);
			
		}
		
		//Событие по нажатию на кнопку (закрывает окно)
		private function onClickOK(e:Event):void
		{
			GameGlobal.Level.removeChild(this);
		}
		
	}

}