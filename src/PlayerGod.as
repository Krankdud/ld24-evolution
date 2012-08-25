package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	public class PlayerGod extends BaseEntity
	{
		private const ACCELERATION:Number = 0.8;
		private const MAX_SPEED:int = 4;
		private const DASH_SPEED:int = 8;
		private const DASH_TIME:int = 20;
		
		private var _intro:Boolean = true;
		private var _dashing:Boolean = false;
		private var _right:Boolean = true;
		
		private var _dashTimer:int;
		
		public function PlayerGod() 
		{
			super(x, y, Image.createRect(32, 48, 0xFFFF00));
			setHitbox(32, 48, 8, 8);
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
			else if (!Global.end)
			{
				if (Input.check(Key.RIGHT))
				{
					speed.x += ACCELERATION;
					_right = true;
				}
				else if (Input.check(Key.LEFT))
				{
					speed.x -= ACCELERATION;
					_right = false;
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
				
				if (Input.pressed(Key.X))
				{
					_dashing = true;
					_dashTimer = DASH_TIME;
				}
				
				if (Input.pressed(Key.C))
				{
					var c:Entity = collide("solid", x + (_right ? 8 : -8), y);
					if (c)
					{
						(c as EnemyPlanet).punched(_right);
					}
				}
				
				speed.x = FP.clamp(speed.x, -MAX_SPEED, MAX_SPEED);
				speed.y = FP.clamp(speed.y, -MAX_SPEED, MAX_SPEED);
				
				if (_dashing)
				{
					speed.x = _right ? DASH_SPEED : -DASH_SPEED;
					c = collide("solid", x + (_right ? 8 : -8), y);
					if (c)
					{
						(c as EnemyPlanet).punched(_right);
					}
				}
				
				if (_dashTimer <= 0)
				{
					_dashing = false;
				}
				else
					_dashTimer--;
			}
			else
			{
				speed.x = 0;
				speed.y = 0;
				
				if (Global.endTimer <= 120)
					(graphic as Image).scale += 1;
			}
			
			if (!Global.end)
			{
				c = collide("enemy", x + speed.x, y + speed.y);
				if (c)
				{
					if (_dashing)
					{
						FP.world.recycle(c);
					}
				}
			}
			
			super.update();
		}
		
	}

}