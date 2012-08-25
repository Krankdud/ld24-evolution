package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlayerCritter extends BaseEntity
	{
		private const ACCELERATION:Number = 0.4;
		private const MAX_SPEED:int = 4;
		private const HIT_TIME:int = 60;
		
		public var hit:Boolean = false;
		private var _hitTimer:int;
		
		private var _intro:Boolean = true;
		
		public function PlayerCritter(x:int, y:int) 
		{
			super(x, y, Image.createRect(8, 8, 0xFFFF00));
			setHitbox(8, 8, 4, 4);
			(graphic as Image).centerOrigin();
			(graphic as Image).scale = 40;
			
			type = "player";
			
			_hitTimer = 0;
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
				hit = false;
				
				if (Input.check(Key.RIGHT))
				{
					speed.x += ACCELERATION;
				}
				else if (Input.check(Key.LEFT))
				{
					speed.x -= ACCELERATION;
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
				
				if (!collide("solid", x, y + speed.y))
				{
					speed.y += ACCELERATION;
				}
				
				speed.x = FP.clamp(speed.x, -MAX_SPEED, MAX_SPEED);
				var e:Entity = FP.world.create(ParticleTrail);
				e.x = centerX;
				e.y = centerY;
				
				if (collide("enemy", x + speed.x, y + speed.y))
				{
					hit = true;
					_hitTimer = HIT_TIME;
				}
				
				if (_hitTimer <= 0)
				{
					visible = true;
					hit = false;
				}
				else
				{
					_hitTimer--;
					visible = !visible;
				}
			}
			
			super.update();
			
			x = FP.clamp(x, halfWidth, FP.width - halfWidth);
		}
		
	}

}