package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlayerDust extends BaseEntity
	{
		private const ACCELERATION:Number = 0.3;
		private const MAX_SPEED:int = 6;
		private const HIT_TIME:int = 60;
		
		public var hit:Boolean = false;
		private var _hitTimer:int;
		
		private var _spritemap:Spritemap;
		
		public function PlayerDust(x:int, y:int) 
		{
			super(x, y);
			setHitbox(4, 4, 2, 2);
			
			_spritemap = new Spritemap(Resources.IMG_PLAYERDUST, 6, 6);
			_spritemap.add("thisistheonlyanimationthislittlepieceofdusthas", [0, 1], 0.3);
			_spritemap.play("thisistheonlyanimationthislittlepieceofdusthas");
			
			_spritemap.centerOrigin();
			graphic = _spritemap;
			
			type = "player";
			
			_hitTimer = 0;
			
			Global.camera.setFollow(this);
		}
		
		override public function update():void
		{
			if (Input.check(Key.RIGHT) && !Global.end)
			{
				speed.x += ACCELERATION;
			}
			else
				speed.x -= ACCELERATION;
				
			speed.x = FP.clamp(speed.x, 0, MAX_SPEED);
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			
			if (!Global.end)
			{
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
			
			if (Global.end)
			{
				visible = true;
				if (Global.endTimer <= 120)
					_spritemap.scale += 1;
			}
			
			super.update();
		}
		
	}

}