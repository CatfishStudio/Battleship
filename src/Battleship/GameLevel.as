package Battleship 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class GameLevel extends Sprite
	{
		/* Окно главного меню */
		private var _wStartMenu:WindowStartMenu = new WindowStartMenu();
		/* Панель кораблей*/
		private var _panelShips:PanelShips;
				
		public function GameLevel() 
		{
			/* фоновое изображение (прорисовка игрового поля)*/
			this.addChild(GameGlobal.bgImage);
			
			/*лого + текст*/
			this.addChild(new GameLogo(5, 545));
			var _textLabel:GameLabel = new GameLabel(60, 560, 700, 50, "System", 16, 0xFFFFFF, "<b>Copyright © 2014 Catfish Studio. All rights reserved.<b>");
			this.addChild(_textLabel);
			_textLabel = new GameLabel(550, 550, 300, 50, "System", 16, 0xFFFFFF, "<b>developer: Евгений Сомов<b>");
			this.addChild(_textLabel);
			_textLabel = new GameLabel(550, 570, 300, 50, "System", 16, 0xFFFFFF, "<b>sound: Дмитрий Калинченко<b>");
			this.addChild(_textLabel);
			
			/* Главное меню игры */
			_wStartMenu.visible = true;
			_wStartMenu.addEventListener(Event.CHANGE, StartGame);
			this.addChild(_wStartMenu);
			
		}
		
		/* Запуск игры */
		public function StartGame(e:Event):void
		{
			_wStartMenu.visible = false;
			_panelShips = new PanelShips();
			GameGlobal.initUnits(); /* Инициализация юнитов */
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			CreateField(); 		/* Создание игрового поля пользователя и пк */
			ShowPanelShips(); 	/* Панель доступных кораблей */
			/* главне кнопки игры: Переиграть и Опции*/
			this.addChild(new ButtonNewGame());
			this.addChild(new ButtonOptions());
			this.addChild(new ButtonScouting());
			/*Воспроизведение музыки*/
			GameSounds.PlayMusic();
		}
		
		/* построение игрового поля */
		private function CreateField():void
		{
			GameGlobal.userField = GameGlobal.CreateSpriteArray2D(10, 10, FieldCell);
			GameGlobal.clearField(10, 10, GameGlobal.userField, "user"); //очистка и установка параетров
			GameGlobal.pcField = GameGlobal.CreateSpriteArray2D(10, 10, FieldCell);
			GameGlobal.clearField(10, 10, GameGlobal.pcField, "pc"); //очистка и установка параетров
			
			var xOrigUser:int = 43;	var yOrigUser:int = 202;
			var xOrigPC:int = 429;	var yOrigPC:int = 202;
			for (var i:int = 0; i < 10; i++){
				for (var j:int = 0; j < 10; j++) {
					/*Поле пользователя*/
					GameGlobal.userField[i][j].x = xOrigUser + (33 * j);
					GameGlobal.userField[i][j].y = yOrigUser + (33 * i);
					GameGlobal.userField[i][j].indexI = i;
					GameGlobal.userField[i][j].indexJ = j;
					this.addChild(GameGlobal.userField[i][j]);
					/*Поле ПК*/
					GameGlobal.pcField[i][j].x = xOrigPC + (33 * j);
					GameGlobal.pcField[i][j].y = yOrigPC + (33 * i);
					GameGlobal.pcField[i][j].indexI = i;
					GameGlobal.pcField[i][j].indexJ = j;
					this.addChild(GameGlobal.pcField[i][j]);
				}
			}
			
		}
		
		/* Панель доступных кораблей */
		private function ShowPanelShips():void
		{
			_panelShips.addChild(new  WindowButtonRotat()); // кнопка панели "поворот"
			_panelShips.addChild(new  WindowButtonReset(150, 270)); // кнопка панели "сброс"
			_panelShips.addChild(new  WindowButtonBack()); // кнопка панели "отмена"
			this.addChild(_panelShips); // отображение панели
			GameGlobal.showUnitsInPanel(this); //Отображение кораблей на панели
		}
		
		/*События  --------------------------------------------*/
		private function onMouseMove(e:MouseEvent):void
		{
			if(GameGlobal.actionUnit != null){
				GameGlobal.actionUnit.x = e.stageX + 5; GameGlobal.actionUnit.y = e.stageY + 5;
			}
		}
		
	}

}