package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Stamp;

	public class FourthWorld extends World
	{
		private var _timer:int;
		
		public function FourthWorld() 
		{
			super();
			
			Global.end = false;
			Global.endTimer = Global.END_TIME;
			
			Global.player = new PlayerBull(0, 0);
			Global.camera.setFollow(Global.player);
			
			Global.hud = new Hud();
			Global.hud.setKey(Key.RIGHT);
			Global.hud.setKey(Key.UP);
			Global.hud.setKey(Key.DOWN);
			Global.hud.setKey(Key.LEFT);
			Global.hud.setKey(Key.X);
			
			Global.friendsFollowing = 0;
			Global.goalFollowing = 20;
			
			add(new BullBackground());
			add(Global.player);
			add(Global.hud);
			
			_timer = 140;
		}
		
		override public function update():void
		{
			if (_timer <= 0)
			{
				create(EnemyBull);
				_timer = 140;
			}
			else
				_timer--;
				
			if (Global.friendsFollowing >= Global.goalFollowing)
				Global.end = true;
				
			if (Global.end)
			{
				if (Global.endTimer <= 0)
					FP.world = new FifthWorld();
				else
					Global.endTimer--;
			}
			
			super.update();
			
			Global.camera.update();
		}
		
	}

}