package  
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	public class EnemyCritter extends BaseEntity
	{
		private const SPEED:Point = new Point(1.5, -8);
		private const GRAVITY:Number = 0.4;
		private const JUMP_TIME:int = 90;
		
		private var _timer:int;
		private var _right:Boolean;
		
		private var _spritemap:Spritemap;
		
		public function EnemyCritter() 
		{
			super(0, 0);
			setHitbox(16, 16, 8, 8);
			
			_spritemap = new Spritemap(Resources.IMG_ENEMYCRITTER, 32, 32);
			_spritemap.add("stand", [0]);
			_spritemap.add("jump", [1]);
			_spritemap.play("stand");
			_spritemap.centerOrigin();
			graphic = _spritemap;
			
			layer = 10;
			
			type = "enemy";
		}
		
		override public function added():void
		{
			x = -16 + Math.round(FP.random) * (FP.width + 32);
			y = FP.halfHeight + FP.random * 32;
			_right = x < FP.halfWidth;
			_spritemap.flipped = !_right;
			speed.x = (_right) ? SPEED.x : -SPEED.x;
			speed.y = FP.random * SPEED.y;
			
			_timer = JUMP_TIME;
		}
		
		override public function update():void
		{
			if (collide("solid", x, y + 4))
			{
				if (_timer <= 0)
				{
					speed.x = (_right) ? SPEED.x : -SPEED.x;
					speed.y = SPEED.y;
					_timer = JUMP_TIME;
				}
				else
					_timer--;
			}
			
			if (collide("solid", x + speed.x, y + speed.y + 1))
			{
				speed.x = 0;
				_spritemap.play("stand");
			}
			else
			{
				speed.y += GRAVITY;
				_spritemap.play("jump");
			}
			
			super.update();
		}
		
	}

}