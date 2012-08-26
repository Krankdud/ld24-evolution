package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
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
		
		private var _spritemap:Spritemap;
		
		public function PlayerCritter(x:int, y:int) 
		{
			super(x, y);
			setHitbox(8, 8, 4, 4);
			
			_spritemap = new Spritemap(Resources.IMG_PLAYERCRITTER, 16, 16);
			_spritemap.add("stand", [0]);
			_spritemap.add("walk", [0, 1], 0.2);
			_spritemap.play("stand");
			
			_spritemap.centerOrigin();
			_spritemap.scale = 40;
			graphic = _spritemap;
			
			type = "player";
			
			_hitTimer = 0;
		}
		
		override public function update():void
		{
			if (_intro)
			{
				if (_spritemap.scale == 1)
				{
					_intro = false;
				}
				else
					_spritemap.scale -= 1;
			}
			else if (!Global.end)
			{
				hit = false;
				
				if (Input.check(Key.RIGHT))
				{
					speed.x += ACCELERATION;
					_spritemap.flipped = false;
				}
				else if (Input.check(Key.LEFT))
				{
					speed.x -= ACCELERATION;
					_spritemap.flipped = true;
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
			else
			{
				visible = true;
				FP.angleXY(speed, FP.angle(x, y, FP.halfWidth, FP.halfHeight), 1);
				
				if (Global.endTimer <= 120)
					_spritemap.scale += 1;
			}
			
			super.update();
			
			if (speed.x == 0 || Global.end)
				_spritemap.play("stand");
			else
				_spritemap.play("walk");
			
			x = FP.clamp(x, halfWidth, FP.width - halfWidth);
		}
		
	}

}