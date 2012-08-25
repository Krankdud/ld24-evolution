package  
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class EnemyCritter extends BaseEntity
	{
		private const SPEED:Point = new Point(1.5, -8);
		private const GRAVITY:Number = 0.4;
		private const JUMP_TIME:int = 90;
		
		private var _timer:int;
		private var _right:Boolean;
		
		public function EnemyCritter() 
		{
			super(0, 0, Image.createRect(16, 16, 0xFF0000));
			setHitbox(16, 16);
			
			layer = 10;
			
			type = "enemy";
		}
		
		override public function added():void
		{
			x = -16 + Math.round(FP.random) * (FP.width + 32);
			y = FP.halfHeight + FP.random * 48;
			_right = x < FP.halfWidth;
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
			
			if (collide("solid", x + speed.x, y + speed.y))
				speed.x = 0;
			else
				speed.y += GRAVITY;
			
			super.update();
		}
		
	}

}