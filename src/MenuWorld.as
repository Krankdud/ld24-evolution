package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class MenuWorld extends World
	{
		private var _fade:Entity;
		private var _fadeout:Boolean;
		
		public function MenuWorld() 
		{
			var title:Text = new Text("We Evolve, TOGETHER!", 64, 32);
			var enter:Text = new Text("Press Enter", 100, 160);
			
			_fadeout = false;
			
			addGraphic(title);
			addGraphic(enter);
			_fade = addGraphic(Image.createRect(320, 240, 0x000000, 0));
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.ENTER))
				_fadeout = true;
			
			if (_fadeout)
			{
				(_fade.graphic as Image).alpha += 0.05;
				
				if ((_fade.graphic as Image).alpha >= 1)
					FP.world = new FirstWorld();
			}
			
			super.update();
		}
		
	}

}