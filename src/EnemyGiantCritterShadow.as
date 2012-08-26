package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;

	public class EnemyGiantCritterShadow extends Entity
	{
		private var _image:Image;
		
		public var fade:Boolean;
		
		public function EnemyGiantCritterShadow(x:int) 
		{
			super(x, FP.height - 64);
			
			_image = Image.createRect(128, 4, 0x000000, 0);
			graphic = _image;
			
			fade = false;
			
			layer = -1;
		}
		
		override public function update():void
		{
			if (_image.alpha < 0.6 && !fade)
				_image.alpha += 0.04;
			else if (fade)
			{
				_image.alpha -= 0.04;
				if (_image.alpha <= 0)
					FP.world.remove(this);
			}
		}
		
	}

}