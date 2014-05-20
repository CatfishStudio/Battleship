package Battleship 
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class GameAI 
	{
		
		public function GameAI() 
		{
			
		}
		
		/* Установка кораблей ПК */
		public static function SetShipsPC(fieldPC:Array):void
		{
			//Подготовка игрового поля ПК
			GameGlobal.clearField(10, 10, fieldPC, "pc");
			//Установка 4-х палубного корабля
			CreateShip(4, 4, fieldPC, GameGlobal.unitsPC, 0);
			//Установка глубинной бомбы
			CreateShip(1, 5, fieldPC, GameGlobal.unitsPC, 1);
			//Установка 3-х палубного корабля
			for (var iS3:int = 0; iS3 < 2; iS3++)
				CreateShip(3, 3, fieldPC, GameGlobal.unitsPC, 2 + iS3);
			//Установка 2-х палубного корабля
			for (var iS2:int = 0; iS2 < 3; iS2++)
				CreateShip(2, 2, fieldPC, GameGlobal.unitsPC, 4 + iS2);
			//Установка 1-но палубного корабля
			for (var iS1:int = 0; iS1 < 4; iS1++)
				CreateShip(1, 1, fieldPC, GameGlobal.unitsPC, 7 + iS1);
		}
		
		/* Случайный выбор */
		public static function RandomSelection():int
		{
			var indexRandom:Number = Math.random() * 10;
			var index:int = Math.round(indexRandom);
			if (index == 10) index--;
			return index;
		}
		
		/* Создание кораблей */
		public static function CreateShip(index:int, type:int, fieldPC:Array, UnitsPC:Array, iUnitsPC:int):void 
		{
			var i:int = RandomSelection();
			var j:int = RandomSelection();
			var r:int = RandomSelection();
			var done:Boolean = true;
			var cells:Array = [];
			
			do {
				i = RandomSelection();
				j = RandomSelection();
				r = RandomSelection();
				done = true;
				cells = [];
				for (var iShip:int = 0; iShip < index; iShip++) {
					//горизонтальное положение
					if (r < 5) {
						if ((j + index) < 10) { // проверка края поля
							if (fieldPC[i][j + iShip].typeShipSet == 0) {
								cells.push([i, j + iShip]);
							}else done = false;
						}else { // компинсация конца игрового поля
							if (fieldPC[i][j - iShip].typeShipSet == 0) {
								cells.push([i, j - iShip]);
							}else done = false;
						}
					}
					//вертикальное положение
					if (r >= 5) {
						if ((i + index) < 10) { // компинсация конца игрового поля
							if (fieldPC[i + iShip][j].typeShipSet == 0){
								cells.push([i + iShip, j]);
							}else done = false;
						}else { // компинсация конца игрового поля
							if (fieldPC[i - iShip][j].typeShipSet == 0){
								cells.push([i - iShip, j]);
							}else done = false;
						}
					}
				}
				
				
			}while (done == false);
			// ЯЧЕЙКИ: перенос данных на игровое поле пк (установка корабля)
			for (var iCell:int = 0; iCell < index; iCell++){
				///////////fieldPC[cells[iCell][0]][cells[iCell][1]].alpha = 1;  // ПОДСВЕТКА ЯЧЕЕК
				fieldPC[cells[iCell][0]][cells[iCell][1]].typeShipSet = type;
			}
			// Запишем в корабль ячейки в которых он находится
			UnitsPC[iUnitsPC].selectCellArray = cells;
			UnitsPC[iUnitsPC].type = type;
			
			// ЮНИТЫ: выставляем корабль на поле
			var cell_I:int = 0; // строка (вертикальное положение)
			var cell_J:int = 10; // колонка (горизональное положение)
			if (r < 5) {
				for (var i_J:int; i_J < cells.length; i_J++){
					if (cell_J > cells[i_J][1]) {
						cell_J = cells[i_J][1];
						cell_I = cells[i_J][0];
					}
				}
				
				UnitsPC[iUnitsPC].x = fieldPC[cell_I][cell_J].x;
				UnitsPC[iUnitsPC].y = fieldPC[cell_I][cell_J].y;
				UnitsPC[iUnitsPC].rotation = 0; // горизонтальное положение
			}
			if (r >= 5) {
				for (var i_I:int; i_I < cells.length; i_I++){
					if (cell_I <= cells[i_I][0]) {
						cell_I = cells[i_I][0];
						cell_J = cells[i_I][1];
					}
					
				}
				
				// Ошибка была в условии cell_I < cells[i_I][0] а нужно было cell_I <= cells[i_I][0]
				//trace("cell_I = " + cell_I.toString() + "   |  cell_J = " + cell_J.toString());
				//if (cell_I == 10) cell_I = 9; // была ошибка (исправлена)
				//if (cell_J == 10) cell_J = 9; // была ошибка (исправлена) ОШИБКА!!! должно быть 5 а стоит 10 скрин http://clip2net.com/s/6xQXI9  (cell_I = 0   |  cell_J = 10)
				
				
				UnitsPC[iUnitsPC].x = fieldPC[cell_I][cell_J].x;
				UnitsPC[iUnitsPC].y = fieldPC[cell_I][cell_J].y + 32;
				UnitsPC[iUnitsPC].rotation = -90; // вертикальное положение
			}
			UnitsPC[iUnitsPC].visible = false; // СКРЫВАЕМ КОРАБЛИ
			GameGlobal.Level.addChild(UnitsPC[iUnitsPC]);
		}
		
		/* Определяем степень повреждения корабля */
		public static function checkShipDestroy(checkUnits:Array, UnitsPC:Boolean, typeUnit:int, field:Array, indexI:int, indexJ:int):Boolean
		{
			/* checkUnits:Array - это массив (GameGlobal.unitsPC) или (GameGlobal.units)
			 * UnitsClass:Class - это красс юнита (Units) или (Units2)
			 * typeUnit:int - это тип корабля (1,2,3,4,5)
			 * field:Array - это массив игрового поля (userField) и (pcField)
			 * indexI:int - это индекс строки в массиве игрового поля
			 * indexJ:int - это индекс столбца в массиве игрового поля
			 * */
			var shipDestroy:Boolean = true; // флаг уничтоженного корабля
			var shipDefined:Boolean = false; // флаг становится истенным если корабль определён.
			var shipShow:Unit2; // корабль ПК для отображения после уничтожения
			var shipUser:Unit; // корабль Пользователя
			
			//1-но палубный корабль (7-8-9-10) [массив юнитов]->[массив i и j ячеек в юните]->[массив ячеек поля]
			if (typeUnit == 1) {
				for (var iShip1:int = 7; iShip1 < 11; iShip1++) {
					for (var i_1:int = 0; i_1 < checkUnits[iShip1].selectCellArray.length; i_1++) {
						// Определяем корабль по его пренадлежности к активной ячейке (по indexI и indexJ)
						if (checkUnits[iShip1].selectCellArray[i_1][0] == indexI && checkUnits[iShip1].selectCellArray[i_1][1] == indexJ) shipDefined = true;
						if (field[checkUnits[iShip1].selectCellArray[i_1][0]][checkUnits[iShip1].selectCellArray[i_1][1]].cellShipDestroy == false) shipDestroy = false;
						
					}
					if (shipDefined) {
						if (UnitsPC) shipShow = checkUnits[iShip1];
						if (UnitsPC == false) shipUser = checkUnits[iShip1];
						break; // корабль найден - цикл прерываем.
					}else shipDestroy = true; // если корабль не был определён - возвращаем значение по умолчанию
				}
			}
			
			//2-х палубный корабль (4-5-6)
			if (typeUnit == 2) {
				for (var iShip2:int = 4; iShip2 < 7; iShip2++) {
					for (var i_2:int = 0; i_2 < checkUnits[iShip2].selectCellArray.length; i_2++) {
						// Определяем корабль по его пренадлежности к активной ячейке (по indexI и indexJ)
						if (checkUnits[iShip2].selectCellArray[i_2][0] == indexI && checkUnits[iShip2].selectCellArray[i_2][1] == indexJ) shipDefined = true;
						if (field[checkUnits[iShip2].selectCellArray[i_2][0]][checkUnits[iShip2].selectCellArray[i_2][1]].cellShipDestroy == false) shipDestroy = false;
						
					}
					if (shipDefined) {
						if (UnitsPC) shipShow = checkUnits[iShip2];
						if (UnitsPC == false) shipUser = checkUnits[iShip2];
						break; // корабль найден - цикл прерываем.
					}else shipDestroy = true; // если корабль не был определён - возвращаем значение по умолчанию
				}
			}
			
			//3-х палубный корабль (2-3)
			if (typeUnit == 3) {
				for (var iShip3:int = 2; iShip3 < 4; iShip3++) {
					for (var i_3:int = 0; i_3 < checkUnits[iShip3].selectCellArray.length; i_3++) {
						// Определяем корабль по его пренадлежности к активной ячейке (по indexI и indexJ)
						if (checkUnits[iShip3].selectCellArray[i_3][0] == indexI && checkUnits[iShip3].selectCellArray[i_3][1] == indexJ) shipDefined = true;
						if (field[checkUnits[iShip3].selectCellArray[i_3][0]][checkUnits[iShip3].selectCellArray[i_3][1]].cellShipDestroy == false) shipDestroy = false;
						
					}
					if (shipDefined) {
						if (UnitsPC) shipShow = checkUnits[iShip3];
						if (UnitsPC == false) shipUser = checkUnits[iShip3];
						break; // корабль найден - цикл прерываем.
					}else shipDestroy = true; // если корабль не был определён - возвращаем значение по умолчанию
				}
			}
			
			//4-х палубный корабль (0)
			if (typeUnit == 4) {
				for (var iShip4:int = 0; iShip4 < 1; iShip4++) {
					for (var i_4:int = 0; i_4 < checkUnits[iShip4].selectCellArray.length; i_4++) {
						// Определяем корабль по его пренадлежности к активной ячейке (по indexI и indexJ)
						if (checkUnits[iShip4].selectCellArray[i_4][0] == indexI && checkUnits[iShip4].selectCellArray[i_4][1] == indexJ) shipDefined = true;
						if (field[checkUnits[iShip4].selectCellArray[i_4][0]][checkUnits[iShip4].selectCellArray[i_4][1]].cellShipDestroy == false) shipDestroy = false;
					}
					if (shipDefined) {
						if (UnitsPC) shipShow = checkUnits[iShip4];
						if (UnitsPC == false) shipUser = checkUnits[iShip4];
						break; // корабль найден - цикл прерываем.
					}else shipDestroy = true; // если корабль не был определён - возвращаем значение по умолчанию
				}
			}
			
			//Глубинная бомба (1)
			if (typeUnit == 5) {
				for (var iShip5:int = 1; iShip5 < 2; iShip5++) {
					for (var i_5:int = 0; i_5 < checkUnits[iShip5].selectCellArray.length; i_5++) {
						// Определяем корабль по его пренадлежности к активной ячейке (по indexI и indexJ)
						if (checkUnits[iShip5].selectCellArray[i_5][0] == indexI && checkUnits[iShip5].selectCellArray[i_5][1] == indexJ) shipDefined = true;
						if (field[checkUnits[iShip5].selectCellArray[i_5][0]][checkUnits[iShip5].selectCellArray[i_5][1]].cellShipDestroy == false)	shipDestroy = false;
					}
					if (shipDefined) {
						if (UnitsPC) shipShow = checkUnits[iShip5];
						if (UnitsPC == false) shipUser = checkUnits[iShip5];
						break; // корабль найден - цикл прерываем.
					}else shipDestroy = true; // если корабль не был определён - возвращаем значение по умолчанию
				}
			}
			
			// показываем корабль.
			if (UnitsPC && shipShow != null && shipDestroy) { shipShow.visible = true; shipShow.unitDestroy = true; }
			if (UnitsPC == false && shipUser != null && shipDestroy) shipUser.UnitDestroy(); // меняем картинку у корабля пользователя
			// анимация взрыва.
			if (shipDestroy && UnitsPC) shipShow.unitBoom();
			if (shipDestroy && UnitsPC == false) shipUser.unitBoom();
			// возвращаем результат
			return shipDestroy;
		}
		
		/* Взрыв глубинной бомбы */
		public static function depthBomb(ships:Array, field:Array, UnitsPC:Boolean):void
		{
			for (var iShip:int = 0; iShip < ships.length; iShip++) {
				for (var i:int = 0; i < ships[iShip].selectCellArray.length; i++) {
					var i_I:int = ships[iShip].selectCellArray[i][0];
					var j_J:int = ships[iShip].selectCellArray[i][1];
					if (field[i_I][j_J].cellShipDestroy == false && field[i_I][j_J].typeShipSet != 5)
					{
						//создаём экземпляр анимации и отображаем её на поле.
						var shot:Sprite = new Hit(GameGlobal.ImageAnimationHit);
						shot.x = field[i_I][j_J].x; shot.y = field[i_I][j_J].y;
						GameGlobal.Level.addChild(shot);
						//изменение параметров ячейки
						field[i_I][j_J].activeCell = false; //ячейка стала недоступной
						field[i_I][j_J].cellShipDestroy = true; // отмечаем ячейку как чаcть уничтоженного корабля
						// Изменяем параметры корабля и проверяем степень его повреждений
						if (UnitsPC) {
							if (GameAI.checkShipDestroy(GameGlobal.unitsPC, UnitsPC, field[i_I][j_J].typeShipSet, GameGlobal.userField, field[i_I][j_J].indexI, field[i_I][j_J].indexJ)) // если корабль уничтожен показываем анимацию взрыва.
							{
								GameGlobal.totalDestroyPCShips++; // отмечаем уничтоженный корабль компьютера
							}
						}else{
							if (GameAI.checkShipDestroy(GameGlobal.units, UnitsPC, field[i_I][j_J].typeShipSet, GameGlobal.userField, field[i_I][j_J].indexI, field[i_I][j_J].indexJ)) // если корабль уничтожен показываем анимацию взрыва.
							{
								GameGlobal.totalDestroyUserShips++; // отмечаем уничтоженный корабль пользователя
							}
						}
						return;
					}
						
				}
			}
			
		}
		
		/* добивание уже подбитых кораблей пользователя */
		public static function finishPaddedShip(userShips:Array, userField:Array):void
		{
			/* userShips - массив кораблей пользователя
			 * userField - массив ячеек (игровое поле пользователя)
			 * */
			for (var iShip:int = 0; iShip < userShips.length; iShip++) { // обработка кораблей
				if (userShips[iShip].unitDestroy == false) { // если корабль не уничтожен
					// поиск подбитых кораблей
					for (var iCell:int = 0; iCell < userShips[iShip].selectCellArray.length; iCell++) {
						var i_I:int = userShips[iShip].selectCellArray[iCell][0];
						var i_J:int = userShips[iShip].selectCellArray[iCell][1];
						if (userField[i_I][i_J].cellShipDestroy == true) { // если ячейка корабля уничтожена
							if (RandomSelection() > 8 || GameOptions.gameHard) { // уничтожаем весь корабль
								// подбитый корабль найден производим его добивание
								for (var iD:int = 0; iD < userShips[iShip].selectCellArray.length; iD++) {
									//создаём экземпляр анимации и отображаем её на поле.
									var shot:Sprite = new Hit(GameGlobal.ImageAnimationHit);
									shot.x = userField[userShips[iShip].selectCellArray[iD][0]][userShips[iShip].selectCellArray[iD][1]].x; 
									shot.y = userField[userShips[iShip].selectCellArray[iD][0]][userShips[iShip].selectCellArray[iD][1]].y;
									GameGlobal.Level.addChild(shot);
									//изменение параметров ячейки
									userField[userShips[iShip].selectCellArray[iD][0]][userShips[iShip].selectCellArray[iD][1]].activeCell = false; //ячейка стала недоступной
									userField[userShips[iShip].selectCellArray[iD][0]][userShips[iShip].selectCellArray[iD][1]].cellShipDestroy = true; // отмечаем ячейку как чаcть уничтоженного корабля
									// Изменяем параметры корабля и проверяем степень его повреждений
									if (GameAI.checkShipDestroy(GameGlobal.units, false, userField[userShips[iShip].selectCellArray[iD][0]][userShips[iShip].selectCellArray[iD][1]].typeShipSet, GameGlobal.userField, userField[userShips[iShip].selectCellArray[iD][0]][userShips[iShip].selectCellArray[iD][1]].indexI, userField[userShips[iShip].selectCellArray[iD][0]][userShips[iShip].selectCellArray[iD][1]].indexJ)) // если корабль уничтожен показываем анимацию взрыва.
									{
										GameGlobal.totalDestroyUserShips++; // отмечаем уничтоженный корабль.
										GameGlobal.showWindowEndGame(); // ПРОВЕРКА: ЗАВЕРШЕНИЯ ИГРЫ.
										if (GameOptions.SoundOnOff) GameSounds.PlaySoundBoom(); // звук
										trace("Корабль Пользователя добит!!!");
										return;
									}
								}	
							}
						}
					}
				}
			}
		}
		
		/* Добивание корабля пользователя */
		public static function 	attainUserShip(cell:FieldCell, userShips:Array, userField:Array):void
		{
			/* cell - ячейка в которой есть корабль
			 * userShips - массив кораблей пользователя
			 * userField - массив ячеек (игровое поле пользователя)
			 * */
			var shipFind:Boolean = false; // флаг определения корабля
			 
			for (var i1:int = 0; i1 < userShips.length; i1++) { // обработка кораблей
				for (var i2:int = 0; i2 < userShips[i1].selectCellArray.length; i2++) {
					var i_I:int = userShips[i1].selectCellArray[i2][0];
					var i_J:int = userShips[i1].selectCellArray[i2][1];
					if (cell.indexI == i_I && cell.indexJ == i_J) {
						shipFind = true;
					}
				}
				
				if (shipFind) { // корабль определён.
					if (RandomSelection() >=5 || GameOptions.gameHard) { // уничтожаем весь корабль
							
						for (var iD:int = 0; iD < userShips[i1].selectCellArray.length; iD++) {
							//создаём экземпляр анимации и отображаем её на поле.
							var shot:Sprite = new Hit(GameGlobal.ImageAnimationHit);
							shot.x = userField[userShips[i1].selectCellArray[iD][0]][userShips[i1].selectCellArray[iD][1]].x; 
							shot.y = userField[userShips[i1].selectCellArray[iD][0]][userShips[i1].selectCellArray[iD][1]].y;
							GameGlobal.Level.addChild(shot);
							//изменение параметров ячейки
							userField[userShips[i1].selectCellArray[iD][0]][userShips[i1].selectCellArray[iD][1]].activeCell = false; //ячейка стала недоступной
							userField[userShips[i1].selectCellArray[iD][0]][userShips[i1].selectCellArray[iD][1]].cellShipDestroy = true; // отмечаем ячейку как чаcть уничтоженного корабля
							// Изменяем параметры корабля и проверяем степень его повреждений
							if (GameAI.checkShipDestroy(GameGlobal.units, false, userField[userShips[i1].selectCellArray[iD][0]][userShips[i1].selectCellArray[iD][1]].typeShipSet, GameGlobal.userField, userField[userShips[i1].selectCellArray[iD][0]][userShips[i1].selectCellArray[iD][1]].indexI, userField[userShips[i1].selectCellArray[iD][0]][userShips[i1].selectCellArray[iD][1]].indexJ)) // если корабль уничтожен показываем анимацию взрыва.
							{
								GameGlobal.totalDestroyUserShips++; // отмечаем уничтоженный корабль.
								GameGlobal.showWindowEndGame(); // ПРОВЕРКА: ЗАВЕРШЕНИЯ ИГРЫ.
								if (GameOptions.SoundOnOff) GameSounds.PlaySoundBoom(); // звук
								trace("Корабль Пользователя уничтожен добиванием");
								return;
							}
						}	
							
					}else { // промах
						// ...	
					}
					return;
				}
			}
		}
		
		/* Выстрел компьютера */
		public static function shotPC(fieldUser:Array):void
		{
			var cellI:int = RandomSelection();
			var cellJ:int = RandomSelection();
			
			// Компьютер будет стрелять пока не промахнётся.
			do {
				trace("ВЫСТРЕЛ PC!!!");
				// добивание уже раненых кораблей
				finishPaddedShip(GameGlobal.units, GameGlobal.userField);
				// выстрел принят
				if (fieldUser[cellI][cellJ].cellShipDestroy == false && fieldUser[cellI][cellJ].activeCell == true) {
					// ЕСЛИ ПОПАЛИ в цель - включаем анимацию огня
					if (fieldUser[cellI][cellJ].typeShipSet > 0 && fieldUser[cellI][cellJ].typeShipSet < 5) {
						//создаём экземпляр анимации и отображаем её на поле.
						var shot:Sprite = new Hit(GameGlobal.ImageAnimationHit);
						shot.x = fieldUser[cellI][cellJ].x; shot.y = fieldUser[cellI][cellJ].y;
						GameGlobal.Level.addChild(shot);
						//изменение параметров ячейки
						fieldUser[cellI][cellJ].activeCell = false; //ячейка стала недоступной
						fieldUser[cellI][cellJ].cellShipDestroy = true; // отмечаем ячейку как чаcть уничтоженного корабля
						// Изменяем параметры корабля и проверяем степень его повреждений
						if (GameAI.checkShipDestroy(GameGlobal.units, false, fieldUser[cellI][cellJ].typeShipSet, GameGlobal.userField, fieldUser[cellI][cellJ].indexI, fieldUser[cellI][cellJ].indexJ)) // если корабль уничтожен показываем анимацию взрыва.
						{
							GameGlobal.totalDestroyUserShips++; // отмечаем уничтоженный корабль.
							GameGlobal.showWindowEndGame(); // ПРОВЕРКА: ЗАВЕРШЕНИЯ ИГРЫ.
							if (GameOptions.SoundOnOff) GameSounds.PlaySoundBoom(); // звук
							trace("Корабль Пользователя уничтожен");
						}else {
							///////////attainUserShip(fieldUser[cellI][cellJ], GameGlobal.units, GameGlobal.userField);
							trace("Корабль Пользователя подбит");
						}
					} else { // ЕСЛИ ПРОМАХ
						if (fieldUser[cellI][cellJ].typeShipSet != 5) {
							var shotMiss:Sprite = new Miss();
							shotMiss.x = fieldUser[cellI][cellJ].x; shotMiss.y = fieldUser[cellI][cellJ].y;
							GameGlobal.Level.addChild(shotMiss);
							//fieldUser[cellI][cellJ].visible = false; //ячейка стала не видимой
							fieldUser[cellI][cellJ].activeCell = false; //ячейка стала недоступной
						}else { // ПОПАЛ в ГЛУБИННУЮ БОМБУ
							//создаём экземпляр анимации и отображаем её на поле.
							var shot:Sprite = new Hit(GameGlobal.ImageAnimationHit);
							shot.x = fieldUser[cellI][cellJ].x; shot.y = fieldUser[cellI][cellJ].y;
							GameGlobal.Level.addChild(shot);
						
							fieldUser[cellI][cellJ].activeCell = false; //ячейка стала недоступной
							depthBomb(GameGlobal.unitsPC, GameGlobal.pcField, true); // компьютер потеряет корабль
							GameGlobal.showWindowEndGame(); // ПРОВЕРКА: ЗАВЕРШЕНИЯ ИГРЫ.
							trace("ГЛУБИННАЯ БОМБА");
						}
						/*!!! Передаём управление пользователю. !!!*/
						GameGlobal.shootUser = true;
					}
				}else {
					cellI = RandomSelection();
					cellJ = RandomSelection();
				}
			} while (GameGlobal.shootUser == false);
		}
	}

}