package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;

	public class Ripple extends Entity
	{
		private var _spritemap:Spritemap;
		
		public function Ripple() 
		{
			super();
			
			_spritemap = new Spritemap(Resources.IMG_RIPPLE, 128, 128);
			_spritemap.add("ripple", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 0.3, false);
			_spritemap.centerOrigin();
			graphic = _spritemap;
		}
		
		override public function added():void
		{
			_spritemap.play("ripple", true);
			_spritemap.alpha = 1;
		}
		
		override public function update():void
		{
			_spritemap.alpha -= 0.02;
			if (_spritemap.alpha <= 0)
				FP.world.recycle(this);
		}
		
	}

}