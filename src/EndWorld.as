package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class EndWorld extends World
	{
		private var _fade:Image;
		private var _fadeOut:Image;
		private var _sunray:Image;
		private var _fadeTimer:int;
		private var _text1:Text;
		private var _text2:Text;
		private var _textTimer:int;
		private var _canReset:Boolean;
		
		public function EndWorld() 
		{
			super();
			
			_fade = Image.createRect(320, 240);
			addGraphic(_fade, -999);
			
			addGraphic(new Image(Resources.IMG_STARFIELD), 10);
			addGraphic(new Image(Resources.IMG_STARFIELD), 10, 256);
			addGraphic(new Image(Resources.IMG_STARFIELD), 10, 0, 256);
			addGraphic(new Image(Resources.IMG_STARFIELD), 10, 256, 256);
			
			_sunray = new Image(Resources.IMG_SUNRAY);
			_sunray.centerOrigin();
			addGraphic(_sunray, 0, FP.halfWidth, FP.halfHeight);
			
			var sun:Image = new Image(Resources.IMG_SUN);
			sun.centerOrigin();
			addGraphic(sun, 0, FP.halfWidth, FP.halfHeight);
			
			_fadeOut = Image.createRect(320, 240, 0x202020, 0);
			addGraphic(_fadeOut, -50);
			
			_fadeTimer = 300;
			
			_text1 = new Text("And thus the sun was formed", 32, 64);
			var o:Object = new Object();
			o.align = "center";
			_text2 = new Text("THE END\nPress Enter to Restart", 64, 160, o);
			
			_textTimer = 300;
			
			_canReset = false;
		}
		
		override public function update():void
		{
			if (_fade.alpha > 0)
				_fade.alpha -= 0.01;
				
			if (_fadeTimer <= 0)
			{
				_fadeOut.alpha += 0.01;
				
				if (_fadeOut.alpha >= 1)
				{
					if (_textTimer == 1)
						addGraphic(_text2, -100);
					else if (_textTimer == 160)
						_canReset = true;
					else if (_textTimer == 180)
						addGraphic(_text1, -100);
					
					if (_textTimer > 0)
						_textTimer--;
				}
			}
			else
				_fadeTimer--;
				
			_sunray.angle -= 0.5;
			
			if (_canReset && Input.pressed(Key.ENTER))
				FP.world = new MenuWorld();
			
			super.update();
		}
		
	}

}