package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class FifthWorld extends World
	{
		private var _timer:int;
		private var _waveTimer:int;
		
		public function FifthWorld() 
		{
			super();
			
			FP.screen.color = 0x007dff;
			
			Global.end = false;
			Global.endTimer = Global.END_TIME;
			
			Global.player = new PlayerDragon();
			Global.camera.setFollow(Global.player);
			
			Global.hud = new Hud();
			Global.hud.setKey(Key.RIGHT);
			Global.hud.setKey(Key.UP);
			Global.hud.setKey(Key.DOWN);
			Global.hud.setKey(Key.LEFT);
			//Global.hud.setKey(Key.X);
			Global.hud.setKey(Key.C);
			
			Global.friendsFollowing = 0;
			Global.goalFollowing = 20;
			
			add(Global.player);
			add(Global.hud);
			
			_timer = 100;
			_waveTimer = 10;
		}
		
		override public function update():void
		{
			if (!Global.end)
			{
				if (_timer <= 0)
				{
					if (FP.random < 0.3)
						create(EnemyBattleship);
					else
						create(FriendBird);
					_timer = 40;
				}
				else
					_timer--;
			}
			
			if (_waveTimer <= 0)
			{
				var e:Entity = create(Wave);
				e.x = Global.camera.x - 32 + FP.random * (FP.width + 64);
				e.y = Global.camera.y - 32 + FP.random * (FP.height + 64);
				_waveTimer = 10;
			}
			else
				_waveTimer--;
			
			if (Global.friendsFollowing >= Global.goalFollowing)
				Global.end = true;
				
			if (Global.end)
			{
				if (Global.endTimer <= 0)
					FP.world = new SixthWorld();
				else
					Global.endTimer--;
			}
			
			super.update();
			
			Global.camera.update();
		}
		
	}

}