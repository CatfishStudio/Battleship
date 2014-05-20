package Battleship 
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class GameLabel extends TextField
	{
		
		public function GameLabel(x:int, y:int, w:int, h:int, font:String, size:int, color:int, text:String) 
		{
			this.x = x;	this.y = y;
			this.width = w;	this.height = h;
			this.defaultTextFormat = new TextFormat(font, size, color);
			this.htmlText = text;
		}
	}

}