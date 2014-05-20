package Battleship 
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Miss extends Sprite
	{
		
		public function Miss() 
		{
			this.graphics.beginFill(0x000044, 0.5);
			this.graphics.drawCircle(16, 16, 15);
			this.graphics.endFill();
			// Звук промаха
			if (GameOptions.SoundOnOff) GameSounds.PlaySoundMiss();
		}
		
	}

}