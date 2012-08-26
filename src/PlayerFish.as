package  
{	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class PlayerFish extends BaseEntity
	{
		private const ACCELERATION:Number = 0.4;
		private const MAX_SPEED:int = 4;
		private const HIT_TIME:int = 60;
		
		private var _intro:Boolean = true;
		
		private var _spritemap:Spritemap;
		
		public function PlayerFish(x:int, y:int) 
		{
			super(x, y, Image.createRect(12, 12, 0xFFFF00));
			setHitbox(12, 12, 6, 6);
			
			_spritemap = new Spritemap(Resources.IMG_PLAYERFISH, 20, 20);
			_spritemap.add("swimx", [0, 1], 0.2);
			_spritemap.add("swimy", [2, 3], 0.2);
			_spritemap.play("swimy");
			
			_spritemap.centerOrigin();
			_spritemap.scale = 40;
			graphic = _spritemap;
			
			type = "player";
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
			}
			else
			{
				speed.x = 0;
				speed.y = 0;
				
				if (Global.endTimer <= 120)
					_spritemap.scale += 1;
			}
			
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			(e as ParticleTrail).setColor(0x00FFFF);
			
			if (speed.x != 0)
			{
				_spritemap.play("swimx");
				_spritemap.flipped = speed.x < 0;
			}
			else
			{
				_spritemap.play("swimy");
				_spritemap.scaleY = speed.y < 0 ? -1 : 1;
			}
			
			super.update();
		}
		
	}

}