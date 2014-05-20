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
	public class WindowOptions extends Sprite
	{
		private var _iWinOptions:Bitmap = new GameGlobal.ImagePanelShips();
		private var _ButtonOK:WindowButtonOK = new WindowButtonOK();
		private var _rbMusic:WindowRadioButton;
		private var _rbSound:WindowRadioButton;
		private var _rbHard:WindowRadioButton;
		private var _nameWindow:GameLabel;
		private var _text1:GameLabel;
		private var _text2:GameLabel;
		private var _text3:GameLabel;
		
		public function WindowOptions() 
		{
			
			Mouse.cursor = MouseCursor.AUTO;
			//координаты окна по умолчанию
			this.x = 0; this.y = 0;
			//Перекрывающая область.
			this.graphics.beginFill(0x000000, 0.8);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			//картинка окна
			_iWinOptions.x = 230;
			_iWinOptions.y = 100;
			this.addChild(_iWinOptions);
			
			// Подпись окна
			if (GameOptions.RusEng) {
				_nameWindow = new GameLabel(340, 140, 300, 50, "Aria", 24, 0x0000A3, "Настройки игры:");
			}else {
				_nameWindow = new GameLabel(340, 140, 300, 50, "Aria", 24, 0x0000A3, "Game settings:");
			}
			this.addChild(_nameWindow);
			
			//кнопка ОК
			_ButtonOK.x = 335; _ButtonOK.y = 350;
			_ButtonOK.addEventListener(Event.CHANGE, onClickOK);
			this.addChild(_ButtonOK);
			
			//Настройка Музыки
			_rbMusic = new WindowRadioButton(GameOptions.MusicOnOff);
			_rbMusic.x = 275; _rbMusic.y = 170;
			_rbMusic.addEventListener(Event.CHANGE, onMusicClick);
			this.addChild(_rbMusic);
			if (GameOptions.RusEng) {
				_text1 = new GameLabel(320, 180, 300, 50, "System", 16, 0x0000A3, "Воспроизводить музыку (да/нет)");
			}else {
				_text1 = new GameLabel(320, 180, 300, 50, "System", 16, 0x0000A3, "Play music (yes / no)");
			}
			this.addChild(_text1);
						
			//Настройка Звука
			_rbSound = new WindowRadioButton(GameOptions.SoundOnOff);
			_rbSound.x = 275; _rbSound.y = 230;
			_rbSound.addEventListener(Event.CHANGE, onSoundClick);
			this.addChild(_rbSound);
			if (GameOptions.RusEng) {
				_text2 = new GameLabel(320, 240, 300, 50, "System", 16, 0x0000A3, "Воспроизводить звуки (да/нет)");
			}else {
				_text2 = new GameLabel(320, 240, 300, 50, "System", 16, 0x0000A3, "Play sound (yes / no)");
			}
			this.addChild(_text2);
			
			//Настройка сложности
			_rbHard = new WindowRadioButton(GameOptions.gameHard);
			_rbHard.x = 275; _rbHard.y = 290;
			_rbHard.addEventListener(Event.CHANGE, onHardClick);
			this.addChild(_rbHard);
			if (GameOptions.RusEng) {
				_text3 = new GameLabel(320, 300, 300, 50, "System", 16, 0x0000A3, "Сложный режим игры (да/нет)");
			}else {
				_text3 = new GameLabel(320, 300, 300, 50, "System", 16, 0x0000A3, "Hard mode (yes / no)");
			}
			this.addChild(_text3);
			
			
			this.name = "WindowOptions";
		}
		
		//Событие по нажатию на кнопку (закрывает окно)
		private function onClickOK(e:Event):void
		{
			GameGlobal.Level.removeChild(this);
		}
		
		//Событие настройка музыки
		private function onMusicClick(e:Event):void
		{
			if (GameOptions.MusicOnOff) {
				GameOptions.MusicOnOff = false;
				GameSounds.StopMusic(); //остановить музыку
			}else {
				GameOptions.MusicOnOff = true;
				GameSounds.PlayMusic(); //запустить музыку
			}
		}
		
		//Событие настройка звука
		private function onSoundClick(e:Event):void
		{
			if (GameOptions.SoundOnOff) {
				GameOptions.SoundOnOff = false;
			}else {
				GameOptions.SoundOnOff = true;
			}
		}
		
		//Событие настройка сложности
		private function onHardClick(e:Event):void
		{
			if (GameOptions.gameHard) {
				GameOptions.gameHard = false;
			}else {
				GameOptions.gameHard = true;
			}
		}
		
	}

}