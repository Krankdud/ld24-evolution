package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;

	public class FriendBull extends BaseEntity
	{
		private const KNOCK_TIMER:int = 40;
		
		private var _timer:int;
		private var _follow:Boolean;
		
		public function FriendBull() 
		{
			super(0, 0, Image.createRect(8, 8, 0x00FF00));
			layer = 5;
			setHitbox(8, 8);
			type = "friend";
		}
		
		override public function added():void
		{
			FP.angleXY(speed, 360 * FP.random, 4);
			_follow = false;
			
			_timer = KNOCK_TIMER;
			
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
			if (_timer <= 0)
			{
				speed.x = 0;
				speed.y = 0;
			}
			else
				_timer--;
			if (_follow)
			{
				FP.angleXY(speed, FP.angle(centerX, centerY, Global.player.centerX, Global.player.centerY), 4);
				if (collide("friend", x + speed.x, y + speed.y) || collide("player", x + speed.x, y + speed.y))
				{
					speed.x = 0;
					speed.y = 0;
				}
				
				if (!Global.end)
				{
					if ((Global.player as PlayerBull).hit)
					{
						_follow = false;
						Global.friendsFollowing--;
						_timer = KNOCK_TIMER;
						FP.angleXY(speed, 360 * FP.random, 4);
					}
				}
				
				if (Global.end)
				{
					if (Global.endTimer <= 180)
						FP.angleXY(speed, FP.angle(centerX, centerY, Global.player.x, Global.player.y), 3);
				}
			}
			
			if (Global.endTimer <= 1)
				FP.world.remove(this);
			
			if (collide("player", x, y) && _timer <= 0 && !_follow)
			{
				_follow = true;
				Global.friendsFollowing++;
			}
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) > FP.width * 3)
				FP.world.recycle(this);
				
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			
			super.update();
		}
		
	}

}