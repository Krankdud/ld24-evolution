package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class FifthWorld extends World
	{
		private var _timer:int;
		
		public function FifthWorld() 
		{
			super();
			
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