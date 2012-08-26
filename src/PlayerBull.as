package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	public class PlayerBull extends BaseEntity
	{
		private const ACCELERATION:Number = 0.8;
		private const MAX_SPEED:int = 4;
		private const DASH_SPEED:int = 8;
		private const DASH_TIME:int = 30;
		private const HIT_TIME:int = 60;
		
		public var hit:Boolean = false;
		private var _hitTimer:int;
		
		private var _intro:Boolean = true;
		private var _dashing:Boolean = false;
		private var _right:Boolean = true;
		
		private var _dashTimer:int;
		
		private var _spritemap:Spritemap;
		
		public function PlayerBull(x:int, y:int) 
		{
			super(x, y, Image.createRect(16, 16, 0xFFFF00));
			setHitbox(16, 16, 8, 8);
			
			_spritemap = new Spritemap(Resources.IMG_PLAYERBULL, 48, 48);
			_spritemap.add("stand", [0]);
			_spritemap.add("walk", [0, 1], 0.2);
			_spritemap.add("charge", [2, 3], 0.4);
			_spritemap.play("stand");
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
					_right = true;
					_spritemap.flipped = false;
				}
				else if (Input.check(Key.LEFT))
				{
					speed.x -= ACCELERATION;
					_right = false;
					_spritemap.flipped = true;
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
				
				speed.x = FP.clamp(speed.x, -MAX_SPEED, MAX_SPEED);
				speed.y = FP.clamp(speed.y, -MAX_SPEED, MAX_SPEED);
				
				if (_dashing)
				{
					speed.x = _right ? DASH_SPEED : -DASH_SPEED;
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
				
				if (Global.endTimer == 120)
					Resources.sfxEvolve.play();
				
				if (Global.endTimer <= 120)
					_spritemap.scale += 1;
			}
			
			if (!Global.end)
			{
				var c:Entity = collide("enemy", x + speed.x, y + speed.y);
				if (c)
				{
					if (_dashing)
					{
						FP.world.recycle(c);
					}
				}
				
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
			
			if ((speed.x != 0 || speed.y != 0) && !Global.end)
			{
				if (_dashing)
					_spritemap.play("charge");
				else
					_spritemap.play("walk");
			}
			else
				_spritemap.play("stand");
			
			super.update();
		}
		
	}

}