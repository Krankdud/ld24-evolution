package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class EnemyPlanet extends BaseEntity
	{
		private const PUNCH_SPEED:int = 8;
		
		public function EnemyPlanet() 
		{
			super(0, 0, Image.createCircle(32, 0xFF0000));
			setHitbox(64, 64);
			graphic.x = -8;
			graphic.y = -16;
			collideWithSolids = false;
			type = "solid";
		}
		
		override public function added():void
		{
			x = Global.camera.x - 64 + Math.round(FP.random) * (FP.width + 128);
			y = Global.camera.y - 64 + Math.round(FP.random) * (FP.height + 128);
			
			speed.x = 0;
			speed.y = 0;
		}
		
		public function punched(right:Boolean):void
		{
			speed.x = right ? PUNCH_SPEED : -PUNCH_SPEED;
			speed.y = -2 + FP.random * 4;
			
			var spirits:int = 20 + FP.random * 80;
			for (var i:int = 0; i < spirits; i++)
			{
				var e:Entity = FP.world.create(FriendSpirit);
				e.x = centerX;
				e.y = centerY;
			}
		}
		
		override public function update():void
		{
			if (x < Global.camera.x - 256 || x > Global.camera.x + FP.width + 256
				|| y < Global.camera.y - 256 || y > Global.camera.y + FP.height + 256)
			{
				FP.world.recycle(this);
			}
			
			super.update();
		}
		
	}

}