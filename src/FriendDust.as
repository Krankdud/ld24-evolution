package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;

	public class FriendDust extends BaseEntity
	{
		private var _follow:Boolean;
		private const ACCELERATION:Number = 0.3;
		
		private var _spritemap:Spritemap;
		
		public function FriendDust() 
		{
			super(0, 0);
			setHitbox(4, 4, 2, 2);
			
			_spritemap = new Spritemap(Resources.IMG_FRIENDDUST, 6, 6);
			_spritemap.add("anim", [0, 1], 0.2);
			_spritemap.play("anim");
			_spritemap.centerOrigin();
			graphic = _spritemap;
			
			layer = 50;
			type = "friend";
		}
		
		override public function added():void
		{
			x = Global.camera.x - 20 + FP.random * (FP.width + 40);
			y = Global.camera.y - 10 + Math.round(FP.random) * (FP.height + 20);
			
			var ang:Number = FP.angle(x, y, Global.player.x, Global.player.y);
			ang += -20 + FP.random * 40;
			FP.angleXY(speed, ang, 1 + FP.random * 2);
			
			_follow = false;
		}
		
		override public function removed():void
		{
			if (_follow)
			{
				if (!Global.end)
					Resources.sfxHit.play();
				Global.friendsFollowing--;
			}
		}
		
		override public function update():void
		{
			if (x < Global.camera.x - 100 || x > Global.camera.x + FP.width + 100
				|| y < Global.camera.y - 100 || y > Global.camera.y + FP.height + 100)
				FP.world.recycle(this);
			
			if (_follow)
			{
				if (x < Global.player.x)
					speed.x += ACCELERATION;
				else
					speed.x -= ACCELERATION;
					
				if (y < Global.player.y)
					speed.y += ACCELERATION * 0.5;
				else
					speed.y -= ACCELERATION * 0.5;
					
				speed.x = FP.clamp(speed.x, -4, 4);
				speed.y = FP.clamp(speed.y, -2, 2);
				
				if (!Global.end)
				{
					if ((Global.player as PlayerDust).hit)
					{
						_follow = false;
						Global.friendsFollowing--;
					}
				}
				
				if (Global.end)
				{
					if (Global.endTimer <= 180)
						FP.angleXY(speed, FP.angle(centerX, centerY, Global.player.x, Global.player.y), 1);
					if (Global.endTimer <= 1)
						FP.world.remove(this);
				}
			}
			
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			
			if (collideRect(x + speed.x, y + speed.y, Global.player.x - 16, Global.player.y - 16, 32, 32) && !_follow && !(Global.player as PlayerDust).hit)
			{
				Resources.sfxCollect.play();
				_follow = true;
				Global.friendsFollowing++;
			}
			
			if (collide("enemy", x + speed.x, y + speed.y))
			{
				FP.world.recycle(this);
			}
				
			super.update();
		}
		
	}

}