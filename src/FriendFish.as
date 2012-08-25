package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;

	public class FriendFish extends BaseEntity
	{
		private const SPEED:Number = 0.5;
		
		private var _angle:int;
		private var _follow:Boolean;
		
		public function FriendFish() 
		{
			super(0, 0, Image.createRect(4, 4, 0x00FF00));
			setHitbox(4, 4);
			type = "friend";
		}
		
		override public function added():void
		{
			x = Global.camera.x - 8 + Math.round(FP.random) * (FP.width + 16);
			y = Global.camera.y - 8 + Math.round(FP.random) * (FP.height + 16);
			
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
				FP.angleXY(speed, FP.angle(centerX, centerY, Global.player.centerX, Global.player.centerY), 2);
				if (collide("friend", x + speed.x, y + speed.y) || collide("player", x + speed.x, y + speed.y))
				{
					speed.x = 0;
					speed.y = 0;
				}
			}
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) > FP.width)
				FP.world.recycle(this);
				
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			
			if (collide("enemy", x + speed.x, y + speed.y))
				FP.world.recycle(this);
			
			super.update();
		}
		
	}

}