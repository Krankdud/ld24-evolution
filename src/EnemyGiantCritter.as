package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;

	public class EnemyGiantCritter extends BaseEntity
	{
		private const SPEED:int = 8;
		
		private var _timer:int;
		private var _shadow:EnemyGiantCritterShadow;
		
		private var _image:Image;
		
		public function EnemyGiantCritter() 
		{
			super(0, 0);
			setHitbox(128, 128, 64, 64);
			
			_image = new Image(Resources.IMG_ENEMYGIANTCRITTER);
			_image.centerOrigin();
			graphic = _image;
			
			type = "enemy"
			layer = 20;
		}
		
		override public function added():void
		{
			x = halfWidth + FP.random * (FP.width - width)
			y = -1024;
			
			speed.y = SPEED;
			
			_shadow = new EnemyGiantCritterShadow(x - halfWidth);
			FP.world.add(_shadow);
			
			_timer = 140;
			
			_image.flipped = FP.random < 0.5;
			
			super.added();
		}
		
		override public function removed():void
		{
			_shadow.fade = true;
			
			super.removed();
		}
		
		override public function update():void
		{
			if (collide("solid", x, y + 4))
			{
				if (_timer <= 0)
					speed.y = -SPEED;
				else
					_timer--;
			}
			
			if (y < -height * 2 && speed.y < 0)
				FP.world.recycle(this);
			
			super.update();
		}
		
	}

}