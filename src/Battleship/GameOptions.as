package Battleship 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class GameOptions extends Sprite
	{
		/* опция локализации (русский/английский*/
		public static var RusEng:Boolean = true;
		
		/* опция воспроизведения музыки */
		public static var MusicOnOff:Boolean = true;
		
		/* опция воспроизведения звуков */
		public static var SoundOnOff:Boolean = true;
		
		/* опция сложности игры */
		public static var gameHard:Boolean = false;
		
		public function GameOptions() 
		{
			
		}
		
	}

}