package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	public class PlayerDragon extends BaseEntity
	{
		private const ACCELERATION:Number = 2;
		private const FRICTION:Number = 0.05;
		private const MAX_SPEED:int = 8;
		private const HIT_TIME:int = 60;
		
		public var hit:Boolean = false;
		private var _hitTimer:int;
		
		private var _intro:Boolean = true;
		private var _lastKey:int;
		
		private var _spritemap:Spritemap;
		
		public function PlayerDragon() 
		{
			super(0, 0, Image.createRect(24, 24, 0xFFFF00));
			setHitbox(24, 24, 12, 12);
			
			_spritemap = new Spritemap(Resources.IMG_PLAYERDRAGON, 120, 120);
			_spritemap.add("flyx", [0, 1], 0.1);
			_spritemap.add("flyy", [2, 3], 0.1);
			_spritemap.play("flyx");
			
			_lastKey = Key.RIGHT;
			
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
				if (Input.check(Key.UP))
				{
					_lastKey = Key.UP;
					_spritemap.play("flyy");
					_spritemap.scaleY = -1;
				}
				else if (Input.check(Key.DOWN))
				{
					_lastKey = Key.DOWN;
					_spritemap.play("flyy");
					_spritemap.scaleY = 1;
				}
				
				if (Input.check(Key.RIGHT))
				{
					_lastKey = Key.RIGHT;
					_spritemap.play("flyx");
					_spritemap.flipped = false;
				}
				else if (Input.check(Key.LEFT))
				{
					_lastKey = Key.LEFT;
					_spritemap.play("flyx");
					_spritemap.flipped = true;
				}
				
				if (speed.x > 0.3)
					speed.x -= FRICTION;
				else if (speed.x < -0.3)
					speed.x += FRICTION;
				else
					speed.x = 0;
				
				if (speed.y > 0.3)
					speed.y -= FRICTION;
				else if (speed.y < -0.3)
					speed.y += FRICTION;
				else
					speed.y = 0;
				
				if (Input.pressed(Key.C))
				{
					// FIRE ZE FIREBALLS OF DOOM
					e = FP.world.create(PlayerFireball);
					Resources.sfxFireball.play();
					switch (_lastKey)
					{
						case Key.RIGHT:
							e.x = x + halfWidth;
							e.y = y;
							speed.x -= ACCELERATION;
							(e as BaseEntity).speed.x = 6;
							(e as BaseEntity).speed.y = 0;
							break;
						case Key.LEFT:
							e.x = x - halfWidth - 8;
							e.y = y;
							speed.x += ACCELERATION;
							(e as BaseEntity).speed.x = -6;
							(e as BaseEntity).speed.y = 0;
							break;
						case Key.UP:
							e.x = x;
							e.y = y - halfHeight - 8;
							speed.y += ACCELERATION;
							(e as BaseEntity).speed.x = 0;
							(e as BaseEntity).speed.y = -6;
							break;
						case Key.DOWN:
							e.x = x;
							e.y = y - halfHeight;
							speed.y -= ACCELERATION;
							(e as BaseEntity).speed.x = 0;
							(e as BaseEntity).speed.y = 6;
							break;
					}
				}
				
				speed.x = FP.clamp(speed.x, -MAX_SPEED, MAX_SPEED);
				speed.y = FP.clamp(speed.y, -MAX_SPEED, MAX_SPEED);
			}
			else
			{
				speed.x = 0;
				speed.y = 0;
				
				if (Global.endTimer == 120)
					Resources.sfxEvolve.play();
				
				if (Global.endTimer <= 120)
					_spritemap.scale += 1;
			}
			
			if (!Global.end)
			{
				if (collide("enemyfire", x + speed.x, y + speed.y) && !hit)
				{
					Resources.sfxHit.play();
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
			
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			
			super.update();
		}
		
	}

}