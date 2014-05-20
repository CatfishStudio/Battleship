package Battleship 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class WindowStartBattle extends Sprite
	{
		
		public function WindowStartBattle() 
		{
			/*Рабочая область*/
			this.graphics.beginFill(0x000000, 0.6);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			/*отображение окна*/
			GameGlobal.iWindowStartBattle.x = 220;
			GameGlobal.iWindowStartBattle.y = 220;
			this.addChild(GameGlobal.iWindowStartBattle);
			this.addChild(new WindowButtonTheBattle(300, 265)); // кнопка начала сражения
			this.addChild(new WindowButtonReset(420, 265)); // кнопка "сброс"
			this.name = "WindowStartBattle";
		}
		
	}

}