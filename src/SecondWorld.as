package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.FP;

	public class SecondWorld extends World
	{
		private var _timer:int;
		private var _giantTimer:int;
		
		public function SecondWorld() 
		{
			super();
			
			Global.camera.setFollow(null);
			Global.camera.x = 0;
			Global.camera.y = 0;
			
			Global.hud.setKey(Key.LEFT);
			
			Global.friendsFollowing = 0;
			Global.goalFollowing = 20;
			
			Global.player = new PlayerCritter(FP.halfWidth, FP.halfHeight);
			addGraphic(Image.createRect(FP.width, 64), 100, 0, FP.height - 64);
			add(Global.player);
			add(Global.hud);
			addMask(new Hitbox(FP.width, 64), "solid", 0, FP.height - 64);
			
			_timer = 60;
			_giantTimer = 1000;
		}
		
		override public function update():void
		{
			if (_timer <= 0)
			{
				if (FP.random < 0.5)
					create(EnemyCritter);
				else
					create(FriendCritter);
				_timer = 110;
			}
			else
				_timer--;
				
			if (_giantTimer <= 0)
			{
				create(EnemyGiantCritter);
				_giantTimer = 1200;
			}
			else
				_giantTimer--;
			
			if (Global.friendsFollowing >= Global.goalFollowing)
				FP.world = new ThirdWorld();
				
			super.update();
		}
		
	}

}