package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class FriendSpirit extends BaseEntity
	{
		private const SPEED:Number = 1;
		private const ACCELERATION:Number = 0.4;
		private const MAX_SPEED:int = 6;
		
		private var _angle:int;
		private var _follow:Boolean;
		
		public function FriendSpirit() 
		{
			super(0, 0, Image.createRect(2, 2, 0x00FF00));
			layer = 5;
			setHitbox(2, 2);
			collideWithSolids = false;
			type = "friend";
		}
		
		override public function added():void
		{
			_angle = 360 * FP.random;
			_follow = false;
			
			super.added();
		}
		
		override public function removed():void
		{
			if (_follow)
				Global.friendsFollowing--;
			
			super.removed();
		}
		
		override public function update():void
		{
			if (!_follow)
			{
				_angle += -16 + 32 * FP.random;
				FP.angleXY(speed, _angle, SPEED);
				
				if (collide("player", x + speed.x, y + speed.y))
				{
					_follow = true;
					Global.friendsFollowing++;
				}
			}
			else
			{
				if (x < Global.player.x)
					speed.x += ACCELERATION;
				else
					speed.x -= ACCELERATION;
					
				if (y < Global.player.y)
					speed.y += ACCELERATION;
				else
					speed.y -= ACCELERATION;
				
				speed.x = FP.clamp(speed.x, -MAX_SPEED, MAX_SPEED);
				speed.y = FP.clamp(speed.y, -MAX_SPEED, MAX_SPEED);
					
				if (Global.end)
				{
					if (Global.endTimer <= 180)
						FP.angleXY(speed, FP.angle(centerX, centerY, Global.player.x, Global.player.y), 1);
					if (Global.endTimer <= 1)
						FP.world.remove(this);
				}
			}
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) > FP.width)
				FP.world.recycle(this);
				
			/*
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			*/
			
			super.update();
		}
		
	}

}