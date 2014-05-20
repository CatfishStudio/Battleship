package Battleship 
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class FieldCell extends Sprite
	{
		public var indexI:int; // индекс строки в массиве
		public var indexJ:int; // индекс столбца в массиве
		public var typeShipSet:int = 0; // тип установленного корабля.
		public var activeCell:Boolean = true; //ячейка доступна
		public var typeCell:String = ""; //тип ячейки user/pc
		public var cellShipDestroy:Boolean = false; // состояние ячейки если в ней корабль (уничтожена или нет)
			
		public function FieldCell() 
		{
			this.alpha = 0;
			/*Рабочая область*/
			this.graphics.beginFill(0xFFFFFF, 0.5);
			this.graphics.drawRect(0, 0, 32, 32);
			this.graphics.endFill();
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
		}
				
		/*События кнопки --------------------------------------------*/
		private function onMouseClickButton(e:MouseEvent):void
		{
			/* обработка ячеек пользователя -------------------------------------------------------------- */
			if (GameGlobal.actionUnit != null && activeCell && typeCell == "user") {
				if (GameOptions.SoundOnOff) GameSounds.PlaySoundMiss(); // звук
				
				//Проверка пустоты выбранных ячеек (если хотя бы одна ячейка не пустая - установка не произойдёт)
				for (var i:int = 0; i < GameGlobal.actionUnit.selectCellArray.length; i++) {
					if (GameGlobal.userField[GameGlobal.actionUnit.selectCellArray[i][0]][GameGlobal.actionUnit.selectCellArray[i][1]].typeShipSet > 0) {
						return ; //отмена установки корабля на поле.
					}
				}
				/* флаг выбранной ячейки как часть корабля */
				for (var i:int = 0; i < GameGlobal.actionUnit.selectCellArray.length; i++) {
					//каждая выбранная ячейка получает значиние: тип корабля.
					GameGlobal.userField[GameGlobal.actionUnit.selectCellArray[i][0]][GameGlobal.actionUnit.selectCellArray[i][1]].typeShipSet = GameGlobal.actionUnit.type;
				}
				/* установить корабль соответственно координатам ячейки */
				if (GameGlobal.actionUnit.rotation == 0){ // горизонтальное положение
					GameGlobal.actionUnit.x = GameGlobal.userField[GameGlobal.actionUnit.selectCellArray[0][0]][GameGlobal.actionUnit.selectCellArray[0][1]].x; 
					GameGlobal.actionUnit.y = GameGlobal.userField[GameGlobal.actionUnit.selectCellArray[0][0]][GameGlobal.actionUnit.selectCellArray[0][1]].y;
					moveShip(0);
				}else{ // вертикальное положение
					GameGlobal.actionUnit.x = GameGlobal.userField[GameGlobal.actionUnit.selectCellArray[GameGlobal.actionUnit.selectCellArray.length-1][0]][GameGlobal.actionUnit.selectCellArray[GameGlobal.actionUnit.selectCellArray.length-1][1]].x; 
					GameGlobal.actionUnit.y = GameGlobal.userField[GameGlobal.actionUnit.selectCellArray[GameGlobal.actionUnit.selectCellArray.length-1][0]][GameGlobal.actionUnit.selectCellArray[GameGlobal.actionUnit.selectCellArray.length-1][1]].y + 35;
					moveShip(0);
				}
				GameGlobal.actionUnit.meSet = true; //корабль установлен на поле
				GameGlobal.actionUnit = null;
				GameGlobal.checkSetShips(); //определяем завершение установки кораблей (если да открываем окно предложение начать сражение)
			}
			
			/* Обработка ячейки противника ---------------------------------------------------------- */
			if (activeCell && typeCell == "pc" && GameGlobal.shootUser) {
				
				trace("ВЫСТРЕЛ USER!!!");
				
				// ЕСЛИ ПОПАЛИ в цель - включаем анимацию огня
				if (typeShipSet > 0 && typeShipSet < 5) {
					//создаём экземпляр анимации и отображаем её на поле.
					var shot:Sprite = new Hit(GameGlobal.ImageAnimationHit);
					shot.x = this.x; shot.y = this.y;
					GameGlobal.Level.addChild(shot);
					//изменение параметров ячейки
					this.visible = false; //ячейка стала не видимой
					this.activeCell = false; //ячейка стала недоступной
					this.cellShipDestroy = true; // отмечаем ячейку как чаcть уничтоженного корабля
					// Изменяем параметры корабля и проверяем степень его повреждений
					if (GameAI.checkShipDestroy(GameGlobal.unitsPC, true, typeShipSet, GameGlobal.pcField, indexI, indexJ)) // если корабль уничтожен показываем анимацию взрыва.
					{
						GameGlobal.totalDestroyPCShips++; // отмечаем уничтоженный корабль.
						GameGlobal.showWindowEndGame(); // ПРОВЕРКА: ЗАВЕРШЕНИЯ ИГРЫ.
						if (GameOptions.SoundOnOff) GameSounds.PlaySoundBoom(); // звук
						trace("Корабль уничтожен");
					}
					
				}else { // ЕСЛИ ПРОМАХ - передаём управление компьютеру
					if (typeShipSet != 5) {
						var shotMiss:Sprite = new Miss();
						shotMiss.x = this.x; shotMiss.y = this.y;
						GameGlobal.Level.addChild(shotMiss);
						this.visible = false; //ячейка стала не видимой
						this.activeCell = false; //ячейка стала недоступной
					}else { // ПОПАЛ в ГЛУБИННУЮ БОМБУ
						this.visible = false; //ячейка стала не видимой
						this.activeCell = false; //ячейка стала недоступной
						this.cellShipDestroy = true; // отмечаем ячейку как чаcть уничтоженного корабля
						if (GameAI.checkShipDestroy(GameGlobal.unitsPC, true, typeShipSet, GameGlobal.pcField, indexI, indexJ)) // если корабль уничтожен показываем анимацию взрыва.
						{
							GameAI.depthBomb(GameGlobal.units, GameGlobal.userField, false); // пользователь потеряет корабль
							GameGlobal.showWindowEndGame(); // ПРОВЕРКА: ЗАВЕРШЕНИЯ ИГРЫ.
							trace("ГЛУБИННАЯ БОМБА");
						}
					}					
					//передаём управление компьютеру (его выстрел)
					GameGlobal.shootUser = false; // флаг - стреляет компьютер
					GameAI.shotPC(GameGlobal.userField); // фукция выстрела ПК
				}
			}
		}
		
		private function onMouseOutButton(e:MouseEvent):void
		{
			if(activeCell){
				moveShip(0);
				alpha = 0;
				Mouse.cursor = MouseCursor.AUTO;
			}
		}
		
		private function onMouseOverButton(e:MouseEvent):void
		{
			if(activeCell){
				moveShip(1);
				alpha = 1;
				Mouse.cursor = MouseCursor.BUTTON;
			}
		}
		
		/* Перемещение корабля по полю --------------------------------------------------------- */
		private function moveShip(alpha:int):void
		{
			// Корабль 4-х палубный.
			if (GameGlobal.actionUnit != null && GameGlobal.actionUnit.type == 4) {
				if (GameGlobal.actionUnit.rotation == 0){ // горизонтальное положение
					if ((indexJ + 3) < 10) {
						GameGlobal.userField[indexI][indexJ + 1].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 2].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 3].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ],[indexI, indexJ + 1],[indexI, indexJ + 2],[indexI, indexJ + 3]];
					}else {
						GameGlobal.userField[indexI][indexJ - 1 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 0 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 1 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 2 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ - 1 - (indexJ + 3 - 10)],[indexI, indexJ + 0 - (indexJ + 3 - 10)],
						[indexI, indexJ + 1 - (indexJ + 3 - 10)], [indexI, indexJ + 2 - (indexJ + 3 - 10)]];
					}
				}else { // вертикальное положение
					if ((indexI - 3) >= 0) {
						GameGlobal.userField[indexI - 1][indexJ].alpha = alpha;
						GameGlobal.userField[indexI - 2][indexJ].alpha = alpha;
						GameGlobal.userField[indexI - 3][indexJ].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI - 3, indexJ], [indexI - 2, indexJ],[indexI - 1, indexJ],[indexI, indexJ]];
					}else {
						GameGlobal.userField[indexI - 1 + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.userField[indexI - 2 + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.userField[indexI - 3 + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.userField[indexI + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI - 1 + (indexI - 3) * -1, indexJ], [indexI - 2 + (indexI - 3) * -1, indexJ],
						[indexI - 3 + (indexI - 3) * -1, indexJ], [indexI + (indexI - 3) * -1, indexJ]];
					}
				}
			}
			// Корабль 3-х палубный.
			if (GameGlobal.actionUnit != null && GameGlobal.actionUnit.type == 3) {
				if (GameGlobal.actionUnit.rotation == 0){ // горизонтальное положение
					if ((indexJ + 2) < 10) {
						GameGlobal.userField[indexI][indexJ + 1].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 2].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ],[indexI, indexJ + 1],[indexI, indexJ + 2]];
					}else {
						GameGlobal.userField[indexI][indexJ + 0 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 1 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 2 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ + 0 - (indexJ + 3 - 10)],
						[indexI, indexJ + 1 - (indexJ + 3 - 10)], [indexI, indexJ + 2 - (indexJ + 3 - 10)]];
					}
				}else { // вертикальное положение
					if ((indexI - 2) >= 0) {
						GameGlobal.userField[indexI - 1][indexJ].alpha = alpha;
						GameGlobal.userField[indexI - 2][indexJ].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI - 2, indexJ], [indexI - 1, indexJ], [indexI, indexJ]];
					}else {
						GameGlobal.userField[indexI - 1 + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.userField[indexI - 2 + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.userField[indexI - 3 + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI - 3 + (indexI - 3) * -1, indexJ],
						[indexI - 2 + (indexI - 3) * -1, indexJ], [indexI - 1 + (indexI - 3) * -1, indexJ]];
					}
				}
			}
			// Корабль 2-х палубный.
			if (GameGlobal.actionUnit != null && GameGlobal.actionUnit.type == 2) {
				if (GameGlobal.actionUnit.rotation == 0){ // горизонтальное положение
					if ((indexJ + 1) < 10) {
						GameGlobal.userField[indexI][indexJ + 1].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ],[indexI, indexJ + 1]];
					}else {
						GameGlobal.userField[indexI][indexJ + 1 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.userField[indexI][indexJ + 2 - (indexJ + 3 - 10)].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ + 1 - (indexJ + 3 - 10)],[indexI, indexJ + 2 - (indexJ + 3 - 10)]];
					}
				}else { // вертикальное положение
					if ((indexI - 1) >= 0) {
						GameGlobal.userField[indexI - 1][indexJ].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI - 1, indexJ], [indexI, indexJ]];
					}else {
						GameGlobal.userField[indexI - 2 + (indexI - 3) * -1][indexJ].alpha = alpha;
						GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ],[indexI - 2 + (indexI - 3) * -1, indexJ]];
					}
				}
			}
			// Корабль 1 палубный.
			if (GameGlobal.actionUnit != null){
				if(GameGlobal.actionUnit.type == 1 || GameGlobal.actionUnit.type == 5)	GameGlobal.actionUnit.selectCellArray = [[indexI, indexJ]];
			}
			
		}
		
	}
}