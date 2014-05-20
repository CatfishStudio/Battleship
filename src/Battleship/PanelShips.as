package Battleship 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class PanelShips extends Sprite
	{
		// массив меток [x,y,text]
		var _labelArrayRus = [[70, 30, "Авианосец."], [200, 30, "Глубинная бомба."],
								[150, 90, "Линкоры."], [150, 145, "Эсминцы."], [120, 210, "Торпедные катера."]];
		var _labelArrayEng = [[70, 30, "Aircraft carrier."], [200, 30, "Depth bomb."],
								[150, 90, "Battleships."], [150, 145, "Destroyers."], [135, 210, "Torpedo  boats."]];	
		var _textLabel:GameLabel;
		public function PanelShips() 
		{
			this.x = 420; this.y = 190;
			this.addChild(GameGlobal.iPanelShips);
			if (GameOptions.RusEng) {
				for (var i:int = 0; i < 5; i++) {
					_textLabel = new GameLabel(_labelArrayRus[i][0], _labelArrayRus[i][1], 700, 50, "System", 16, 0x0000A3, _labelArrayRus[i][2]);
					this.addChild(_textLabel);
				}
			}else {
				for (var i:int = 0; i < 5; i++) {
					_textLabel = new GameLabel(_labelArrayEng[i][0], _labelArrayEng[i][1], 700, 50, "System", 16, 0x0000A3, _labelArrayEng[i][2]);
					this.addChild(_textLabel);
				}
			}
			this.name = "PanelShips";
		}
		
		
	}

}