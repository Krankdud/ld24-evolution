package  
{	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class PlayerFish extends BaseEntity
	{
		private const ACCELERATION:Number = 0.4;
		private const MAX_SPEED:int = 4;
		private const HIT_TIME:int = 60;
		
		private var _intro:Boolean = true;
		
		public function PlayerFish(x:int, y:int) 
		{
			super(x, y, Image.createRect(12, 12, 0xFFFF00));
			setHitbox(12, 12, 6, 6);
			(graphic as Image).centerOrigin();
			(graphic as Image).scale = 40;
			
			type = "player";
		}
		
		override public function update():void
		{
			if (_intro)
			{
				if ((graphic as Image).scale == 1)
				{
					_intro = false;
				}
				else
					(graphic as Image).scale -= 1;
			}
			else
			{
				if (Input.check(Key.RIGHT))
				{
					speed.x += ACCELERATION;
				}
				else if (Input.check(Key.LEFT))
				{
					speed.x -= ACCELERATION;
				}
				
				if (Input.check(Key.UP))
				{
					speed.y -= ACCELERATION;
				}
				else if (Input.check(Key.DOWN))
				{
					speed.y += ACCELERATION;
				}
				
				if (!Input.check(Key.RIGHT) && !Input.check(Key.LEFT))
				{
					if (speed.x > 0.3)
						speed.x -= ACCELERATION;
					else if (speed.x < -0.3)
						speed.x += ACCELERATION;
					else
						speed.x = 0;
				}
				
				if (!Input.check(Key.UP) && !Input.check(Key.DOWN))
				{
					if (speed.y > 0.3)
						speed.y -= ACCELERATION;
					else if (speed.y < -0.3)
						speed.y += ACCELERATION;
					else
						speed.y = 0;
				}
				
				speed.x = FP.clamp(speed.x, -MAX_SPEED, MAX_SPEED);
				speed.y = FP.clamp(speed.y, -MAX_SPEED, MAX_SPEED);
				var e:Entity = FP.world.create(ParticleTrail);
				e.x = centerX;
				e.y = centerY;
			}
			
			super.update();
		}
		
	}

}