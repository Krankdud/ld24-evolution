package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.FP;

	public class ThirdWorld extends World
	{
		private var _timer:int;
		private var _rippleTimer:int;
		
		public function ThirdWorld() 
		{
			super();
			
			FP.screen.color = 0x007dff;
			
			Global.end = false;
			Global.endTimer = Global.END_TIME;
			
			Global.player = new PlayerFish(0, 0);
			Global.camera.setFollow(Global.player);
			
			Global.hud = new Hud();
			Global.hud.setKey(Key.RIGHT);
			Global.hud.setKey(Key.UP);
			Global.hud.setKey(Key.DOWN);
			Global.hud.setKey(Key.LEFT);
			
			Global.friendsFollowing = 0;
			Global.goalFollowing = 20;
			
			add(Global.player);
			add(Global.hud);
			
			_timer = 30;
			_rippleTimer = 10;
		}
		
		override public function update():void
		{
			if (!Global.end)
			{
				if (_timer <= 0)
				{
					if (FP.random < 0.57)
						create(FriendFish);
					else
						create(EnemyFish);
					_timer = 30;
				}
				else
					_timer--;
			}
			
			if (_rippleTimer <= 0)
			{
				var e:Entity = create(Ripple);
				e.x = -16 + FP.random * (FP.width + 16);
				e.y = -16 + FP.random * (FP.height + 16);
				_rippleTimer = 30 + 60 * FP.random;
			}
			else
				_rippleTimer--;
				
			if (Global.friendsFollowing >= Global.goalFollowing)
				Global.end = true;
				
			if (Global.end)
			{
				if (Global.endTimer <= 0)
					FP.world = new FourthWorld();
				else
					Global.endTimer--;
			}
				
			super.update();
			
			Global.camera.update();
		}
		
	}

}