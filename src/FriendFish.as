package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;

	public class FriendFish extends BaseEntity
	{
		private const SPEED:Number = 0.5;
		
		private var _angle:int;
		private var _follow:Boolean;
		
		private var _spritemap:Spritemap;
		
		public function FriendFish() 
		{
			super(0, 0);
			layer = 5;
			setHitbox(4, 4, 2, 2);
			type = "friend";
			
			_spritemap = new Spritemap(Resources.IMG_FRIENDFISH, 8, 8);
			_spritemap.add("swimx", [0, 1], 0.2);
			_spritemap.add("swimy", [2, 3], 0.2);
			_spritemap.play("swimx");
			_spritemap.centerOrigin();
			graphic = _spritemap;
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
					Resources.sfxCollect.play();
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
				
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			(e as ParticleTrail).setColor(0x00FFFF);
			
			if (Math.abs(speed.x) < Math.abs(speed.y))
			{
				_spritemap.play("swimy");
				
				if (speed.y >= 0)
					_spritemap.scaleY = 1;
				else
					_spritemap.scaleY = -1;
			}
			else
			{
				_spritemap.play("swimx");
				
				if (speed.x >= 0)
					_spritemap.flipped = false;
				else
					_spritemap.flipped = true;
			}
			
			if (collide("enemy", x + speed.x, y + speed.y) && !Global.end)
				FP.world.recycle(this);
			
			super.update();
		}
		
	}

}