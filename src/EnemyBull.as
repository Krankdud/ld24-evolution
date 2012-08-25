package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class EnemyBull extends BaseEntity
	{
		private const FIRE_TIME:int = 90;
		private var _running:Boolean;
		private var _fireTimer:int;
		
		public function EnemyBull() 
		{
			super(0, 0, Image.createRect(16, 16, 0xFF0000));
			setHitbox(16, 16);
			layer = 10;
			type = "enemy";
		}
		
		override public function added():void
		{
			x = Global.camera.x - 8 + Math.round(FP.random) * (FP.width + 16);
			y = Global.camera.y - 8 + Math.round(FP.random) * (FP.height + 16);
			
			FP.angleXY(speed, 360 * FP.random, 1);
			
			_running = false;
			_fireTimer = FIRE_TIME;
			
			super.added();
		}
		
		override public function removed():void
		{
			if (FP.distance(x, y, Global.player.x, Global.player.y) < 60)
			{
				for (var i:int = 0; i < 3; i++)
				{
					var e:Entity = FP.world.create(FriendBull);
					e.x = x;
					e.y = y;
				}
			}
		}
		
		override public function update():void
		{
			if (_running)
			{
				FP.angleXY(speed, FP.angle(x, y, Global.player.x, Global.player.y) + 180, 3);
				
				if (_fireTimer <= 0)
				{
					if (FP.random < 0.4)
					{
						var e:Entity = FP.world.create(EnemyFire);
						e.x = x + 3;
						e.y = y + 3;
						_fireTimer = FIRE_TIME;
					}
				}
				else
					_fireTimer--;
			}
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) < 100)	
				_running = true;
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) > FP.width)
				FP.world.recycle(this);
			
			super.update();
		}
		
	}

}