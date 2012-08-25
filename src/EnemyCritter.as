package  
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class EnemyCritter extends BaseEntity
	{
		private const SPEED:Point = new Point(1.5, -6);
		private const GRAVITY:Number = 0.4;
		
		public function EnemyCritter() 
		{
			super(0, 0, Image.createRect(16, 16, 0xFF0000));
			setHitbox(16, 16);
			
			type = "enemy";
		}
		
		override public function added():void
		{
			x = -16 + Math.round(FP.random) * (FP.width + 32);
			y = FP.halfHeight + FP.random * 48;
			speed.x = (x < FP.halfWidth) ? SPEED.x : -SPEED.x;
			speed.y = FP.random * SPEED.y;
		}
		
	}

}