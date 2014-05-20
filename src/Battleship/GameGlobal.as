package Battleship 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
		
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class GameGlobal 
	{
		/* Загрузка фоновой картинки */
		[Embed(source = '../../images/bgimage.png')]
		public static var BGImage:Class;
		public static var bgImage:Bitmap = new BGImage();
		
		/* Загрузка картинок окна начала игры */
		[Embed(source = '../../images/startMenu.png')]
		public static var ImageStartMenu:Class;
		public static var iStartMenu:Bitmap = new ImageStartMenu();
		[Embed(source = '../../images/buttonStart.png')]
		public static var ImageButtonStart:Class;
		public static var iButtonStart:Bitmap = new ImageButtonStart();
		[Embed(source = '../../images/buttonStartRus.png')]
		public static var ImageButtonStartRus:Class;
		public static var iButtonStartRus:Bitmap = new ImageButtonStartRus();
		[Embed(source = '../../images/rus.png')]
		public static var ImageButtonRus:Class;
		public static var iButtonRus:Bitmap = new ImageButtonRus();
		[Embed(source = '../../images/eng.png')]
		public static var ImageButtonEng:Class;
		public static var iButtonEng:Bitmap = new ImageButtonEng();
		
		/* Загрузка картинки логотипа */
		[Embed(source = '../../images/logo.png')]
		public static var ImageLogo:Class;
		public static var iLogo:Bitmap = new ImageLogo();
		
		/* Загрузка картинки панели и кнопок на панели */
		[Embed(source = '../../images/panelShips.png')]
		public static var ImagePanelShips:Class;
		public static var iPanelShips:Bitmap = new ImagePanelShips();
		[Embed(source = '../../images/buttonRotatEng.png')]
		public static var ImageButtonRotatEng:Class;
		[Embed(source = '../../images/buttonRotatRus.png')]
		public static var ImageButtonRotatRus:Class;
		[Embed(source = '../../images/buttonResetEng.png')]
		public static var ImageButtonResetEng:Class;
		[Embed(source = '../../images/buttonResetRus.png')]
		public static var ImageButtonResetRus:Class;
		[Embed(source = '../../images/buttonCancelEng.png')]
		public static var ImageButtonCancelEng:Class;
		[Embed(source = '../../images/buttonCancelRus.png')]
		public static var ImageButtonCancelRus:Class;
		
		/* Загрузка картинок юнитов (целые) */
		[Embed(source = '../../images/ship128_32.png')]
		public static var ImageShip4:Class;
		[Embed(source = '../../images/ship96_32.png')]
		public static var ImageShip3:Class;
		[Embed(source = '../../images/ship64_32.png')]
		public static var ImageShip2:Class;
		[Embed(source = '../../images/ship32_32.png')]
		public static var ImageShip1:Class;
		[Embed(source = '../../images/mine.png')]
		public static var ImageMine:Class;
		/* Загрузка картинок юнитов (разбитые) */
		[Embed(source = '../../images/ship128_32_destroy.png')]
		public static var ImageShipD4:Class;
		[Embed(source = '../../images/ship96_32_destroy.png')]
		public static var ImageShipD3:Class;
		[Embed(source = '../../images/ship64_32_destroy.png')]
		public static var ImageShipD2:Class;
		[Embed(source = '../../images/ship32_32_destroy.png')]
		public static var ImageShipD1:Class;
				
		/* Загрузка картинки окна и кнопки начала сражения */
		[Embed(source = '../../images/windowStartBattle.png')]
		public static var ImageWindowStartBattle:Class;
		public static var iWindowStartBattle:Bitmap = new ImageWindowStartBattle();
		[Embed(source = '../../images/buttonTheBattleEng.png')]
		public static var ImageButtonTheBattleEng:Class;
		[Embed(source = '../../images/buttonTheBattleRus.png')]
		public static var ImageButtonTheBattleRus:Class;
		
		/* Загрузка картинок анимации */
		[Embed(source = '../../images/hit.png')]
		public static var ImageAnimationHit:Class;
		[Embed(source = '../../images/boom.png')]
		public static var ImageAnimationBoom:Class;
		
		/* Загрузка картинки завершения игры */
		[Embed(source = '../../images/windowGameResult.png')]
		public static var ImageEndGame:Class;
		public static var iEndGame:Bitmap = new ImageEndGame();
		
		/* Загрузка картинок кнопок */
		[Embed(source = '../../images/buttonOK.png')]
		public static var ImageButtonOK:Class;
		//public static var iButtonOK:Bitmap = new ImageButtonOK();
		[Embed(source = '../../images/buttonNewGameEng.png')]
		public static var ImageButtonNewGameEng:Class;
		public static var iButtonNewGameEng:Bitmap = new ImageButtonNewGameEng();
		[Embed(source = '../../images/buttonNewGameRus.png')]
		public static var ImageButtonNewGameRus:Class;
		public static var iButtonNewGameRus:Bitmap = new ImageButtonNewGameRus();
		[Embed(source = '../../images/buttonOptionsEng.png')]
		public static var ImageButtonOptionsEng:Class;
		public static var iButtonOptionsEng:Bitmap = new ImageButtonOptionsEng();
		[Embed(source = '../../images/buttonOptionsRus.png')]
		public static var ImageButtonOptionsRus:Class;
		public static var iButtonOptionsRus:Bitmap = new ImageButtonOptionsRus();
		
		/* Загрузка картинок радио кнопки */
		[Embed(source = '../../images/buttonUp.png')]
		public static var ImageButtonUP:Class;
		[Embed(source = '../../images/buttonDown.png')]
		public static var ImageButtonDOWN:Class;
		
		/* Загрузка кнопки "Разведка" */
		[Embed(source = '../../images/buttonScoutingEng.png')]
		public static var ImageButtonScoutingEng:Class;
		public static var iButtonScoutingEng:Bitmap = new ImageButtonScoutingEng();
		[Embed(source = '../../images/buttonScoutingRus.png')]
		public static var ImageButtonScoutingRus:Class;
		public static var iButtonScoutingRus:Bitmap = new ImageButtonScoutingRus();
				
		/* Главный спрайт игры */
		public static var MainSprite:Sprite;
		
		/* Главный спрайт уровня */
		public static var Level:GameLevel; //Главный спрайт (уровень)
				
		/* Массивы игровых полей ---------------------------------*/
		/* Игровое поле пользователя */
		public static var userField:Array = [];
		/* Игровое поле компьютера */
		public static var pcField:Array = [];
		/* ЮНИТЫ -------------------------------------------------*/
		/* Массив Юнитов */
		public static var units:Array = [];		// юниты пользователя
		public static var unitsPC:Array = [];	// юниты компьютера
		// массим: размещение кораблей на панели [x,y,type] (тип: 1,2,3,4,5-мина, 0-ничего)
		public static var unitsArray = [[480, 240, 4], [650, 240, 5], [480, 300, 3],	[620, 300, 3],
								[480, 360, 2], [560, 360, 2], [640, 360, 2],
								[490, 420, 1], [550, 420, 1], [610, 420, 1], [670, 420, 1]];
								
		/* активные юнит */		
		public static var actionUnit:Unit; // выбранный юнит
		/* Кто стреляет */
		public static var shootUser:Boolean = true; // стреляет пользователь
		/* Счёт игры */
		public static var totalDestroyUserShips:int = 0; // количество уничтоженных кораблей пользователя
		public static var totalDestroyPCShips:int = 0; // количество уничтоженных кораблей пк
		/*---------------------------------------------------------*/
		
		/* конструктор класса */
		public function GameGlobal() 
		{

		}
		
		/* Создание 2D массива типом спрайт */
		public static function CreateSpriteArray2D(n:int, m:int, MySprite:Class):Array
		{
			
			var newArray:Array = [];
			for (var i:int = 0; i < n; i++) {
				var newRow:Array = [];
				for (var j:int = 0; j < m; j++) {
					var spriteAdd:Sprite = new MySprite();
					newRow.push(spriteAdd);
				}
				newArray.push(newRow);
			}
			return newArray;
		}
		
		/* Очистка игрового поля */
		public static function clearField(n:int, m:int, field:Array, typeCell:String):void
		{
			for (var i:int = 0; i < n; i++) {
				for (var j:int = 0; j < m; j++) {
					field[i][j].typeShipSet = 0; //очистка ячеек от флагов установленных кораблей
					field[i][j].typeCell = typeCell; //устанавливаем тип ячеек
				}
			}	
		}
		
		/* Устанавливаем все ячейки игрового поля пользователя доступными */
		public static function activeCellField(n:int, m:int, field:Array, activeCell:Boolean):void
		{
			for (var i:int = 0; i < n; i++)
				for (var j:int = 0; j < m; j++)
					field[i][j].activeCell = activeCell;
		}
		
		/* Инициализация юнитов */
		public static function initUnits():void
		{
			units.push(new Unit(ImageShip4, ImageShipD4));		//4-х палубный корабль
			unitsPC.push(new Unit2(ImageShipD4));		//4-х палубный корабль
			units.push(new Unit(ImageMine, ImageMine));		//глубинная мина
			unitsPC.push(new Unit2(ImageMine));		//глубинная мина
			for (var i:int = 0; i < 2; i++) {
				units.push(new Unit(ImageShip3, ImageShipD3));	//3-х палубный корабль
				unitsPC.push(new Unit2(ImageShipD3));	//3-х палубный корабль
			}
			for (var i:int = 0; i < 3; i++) {
				units.push(new Unit(ImageShip2, ImageShipD2));	//2-х палубный корабль
				unitsPC.push(new Unit2(ImageShipD2));	//2-х палубный корабль
			}
			for (var i:int = 0; i < 4; i++) {
				units.push(new Unit(ImageShip1, ImageShipD1));	//1-а палубный корабль
				unitsPC.push(new Unit2(ImageShipD1));	//1-а палубный корабль
			}
		}
		
		/* отображение кораблей на панели выбора */
		public static function showUnitsInPanel(sprite:Sprite):void
		{
			for (var i:int = 0; i < 11; i++) {
				units[i].x = unitsArray[i][0];
				units[i].y = unitsArray[i][1];
				units[i].type = unitsArray[i][2]; //тип корабля
				units[i].index = i; //индекс 
				units[i].meSet = false; // не установленный
				sprite.addChild(units[i]);
			}
		
		}
		
		/* сброс всех кораблей на панель выбора */
		public static function resetUnitsInPanel():void
		{
			for (var i:int = 0; i < 11; i++){
				units[i].meSet = false; // не установленный
				units[i].rotation = 0;	// по горизонтали
				units[i].x = unitsArray[i][0]; units[i].y = unitsArray[i][1];
				units[i].selectCellArray = [];
			}
			actionUnit = null; //очистить выбор.
			clearField(10, 10, userField, "user");
			/* Если открыто окно начала сражения оно будет закрыто */
			if(Level.getChildByName("WindowStartBattle")!= null) Level.removeChild(Level.getChildByName("WindowStartBattle"));
		}
		
		/* возвращаем юнит на панель кораблей */
		public static function backUnitsInPanel():void
		{
			if (actionUnit != null) {
				for (var i:int = 0; i < actionUnit.selectCellArray.length; i++) 
					GameGlobal.userField[GameGlobal.actionUnit.selectCellArray[0][0]][GameGlobal.actionUnit.selectCellArray[0][1]].typeShipSet = 0;
				actionUnit.x = unitsArray[actionUnit.index][0];
				actionUnit.y = unitsArray[actionUnit.index][1];
				actionUnit.meSet = false; // не установленный
				actionUnit.rotation = 0; // по горизонтали
				actionUnit.selectCellArray = []; // очистка массива ячеек которым пренадлежит корабль
				actionUnit = null; //очистить выбор.
			}
		}
		
		/* определяем завершение установки кораблей (если да открываем окно предложение начать сражение) */
		public static function checkSetShips():void 
		{
			for (var i:int = 0; i < units.length; i++) {
				if (units[i].meSet == false) return;
			}
			Level.addChild(new WindowStartBattle());
		}
		
		/* Окно показывающее результат игры */
		public static function showWindowEndGame():void
		{
			// победил компьютер
			if (totalDestroyUserShips == 10 && totalDestroyPCShips < 10) {
				shootUser = true;
				if (GameOptions.RusEng == true)	GameGlobal.Level.addChild(new WindowEndGame("Вы проиграли!!!"));
				if (GameOptions.RusEng == false) GameGlobal.Level.addChild(new WindowEndGame("     You lost!!!"));
			}
			// победил пользователь
			if (totalDestroyPCShips == 10 && totalDestroyUserShips < 10) {
				shootUser = true;
				if (GameOptions.RusEng == true)	GameGlobal.Level.addChild(new WindowEndGame("Вы победили!!!"));
				if (GameOptions.RusEng == false) GameGlobal.Level.addChild(new WindowEndGame("     You won!!!"));
			}
		}
		
		/* Перезапуск игры */
		public static function restartGame():void
		{
			// удаление уровня
			MainSprite.removeChild(GameGlobal.Level);
			
			// восстановление значений по умолчанию
			userField = [];
			pcField = [];
			units = [];
			unitsPC = [];
			actionUnit = null;
			shootUser = true;
			totalDestroyPCShips = 0;
			totalDestroyUserShips = 0;
			GameSounds.StopMusic();
			// создание уровня
			GameGlobal.Level = new GameLevel();
			MainSprite.addChild(GameGlobal.Level);
		}
	}
}