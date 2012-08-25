package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;

	public class EnemyGiantCritter extends BaseEntity
	{
		private const SPEED:int = 8;
		
		private var _timer:int;
		private var _shadow:EnemyGiantCritterShadow;
		
		public function EnemyGiantCritter() 
		{
			super(0, 0, Image.createRect(128, 128, 0xFF0000));
			setHitbox(128, 128);
			type = "enemy"
			layer = 20;
		}
		
		override public function added():void
		{
			x = FP.random * (FP.width - width)
			y = -1024;
			
			speed.y = SPEED;
			
			_shadow = new EnemyGiantCritterShadow(x);
			FP.world.add(_shadow);
			
			_timer = 140;
			
			super.added();
		}
		
		override public function removed():void
		{
			FP.world.remove(_shadow);
			
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