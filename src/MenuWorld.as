package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class MenuWorld extends World
	{
		private var _fade:Entity;
		private var _fadeout:Boolean;
		private var _titleSpritemap:Spritemap;
		
		public function MenuWorld() 
		{
			var title:Text = new Text("We Evolve\nTOGETHER!", 118, 64);
			var enter:Text = new Text("Press Enter", 108, 148);
			
			FP.screen.color = 0x202020;
			
			_fadeout = false;
			
			addGraphic(title);
			addGraphic(enter);
			
			_titleSpritemap = new Spritemap(Resources.IMG_TITLECIRCLE, 240, 240);
			_titleSpritemap.add("spin", [0, 1], 0.2);
			_titleSpritemap.play("spin");
			_titleSpritemap.centerOrigin();
			addGraphic(_titleSpritemap, 10, FP.halfWidth, FP.halfHeight);
			
			_fade = addGraphic(Image.createRect(320, 240, 0x000000, 0));
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.ENTER))
			{
				_fadeout = true;
				Resources.sfxGamestart.play();
			}
			
			if (_fadeout)
			{
				(_fade.graphic as Image).alpha += 0.05;
				
				if ((_fade.graphic as Image).alpha >= 1)
					FP.world = new FirstWorld();
			}
			
			_titleSpritemap.angle += 0.2;
			
			super.update();
		}
		
	}

}