package Battleship 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class GameSounds 
	{
		/* Загрузка звуков ---------------------------------------*/
		[Embed(source = '../../sounds/amb_noise_background_loop.MP3')]
		public static var Sound1:Class;
		public static var Music:Sound = new Sound1() as Sound;
		public static var MusicChannel:SoundChannel;
		
		[Embed(source = '../../sounds/miss_and_ship_set.MP3')]
		public static var Sound2:Class;
		public static var MissSound:Sound = new Sound2() as Sound;
		
		[Embed(source = '../../sounds/ship_hit2.MP3')]
		public static var Sound3:Class;
		public static var HitSound:Sound = new Sound3() as Sound;
		
		[Embed(source = '../../sounds/click.mp3')]
		public static var Sound4:Class;
		public static var ClickSound:Sound = new Sound4() as Sound;
		
		[Embed(source = '../../sounds/boom2.mp3')]
		public static var Sound5:Class;
		public static var BoomSound:Sound = new Sound5() as Sound;
		
		public function GameSounds() 
		{
			
		}
		
		/* МУЗЫКА -------------------------------------------------*/
		public static function PlayMusic():void
		{
			if (GameOptions.MusicOnOff) {
				MusicChannel = Music.play();
				MusicChannel.addEventListener(Event.SOUND_COMPLETE, PlayMusicLoop);
			}
		}
		public static function PlayMusicLoop(e:Event):void
		{
			SoundChannel(e.target).removeEventListener(e.type, PlayMusicLoop);
			if (GameOptions.MusicOnOff) PlayMusic();
		}
		public static function StopMusic():void
		{
			MusicChannel.stop();
		}
		
		/*ЗВУКИ -------------------------------------------*/
		public static function PlaySoundMiss():void
		{
			MissSound.play(1000, 0);
		}
		public static function PlaySoundHit():void
		{
			HitSound.play();
		}
		public static function PlaySoundClick():void
		{
			ClickSound.play();
		}
		public static function PlaySoundBoom():void
		{
			BoomSound.play();
		}
	}

}