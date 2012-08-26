package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;

	public class Wave extends Entity
	{
		
		private var _spritemap:Spritemap;
		
		public function Wave() 
		{
			super();
			
			layer = 900;
			
			_spritemap = new Spritemap(Resources.IMG_WAVE, 64, 16);
			_spritemap.add("dothewave", [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1, 0], 0.2, false);
			_spritemap.centerOrigin();
			graphic = _spritemap;
		}
		
		override public function added():void
		{
			_spritemap.play("dothewave", true);
		}
		
		override public function update():void
		{
			if (_spritemap.complete)
				FP.world.recycle(this);
		}
		
	}

}