package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.utils.Key;

	public class SixthWorld extends World
	{
		private var _timer:int;
		private var _white:Entity;
		
		public function SixthWorld() 
		{
			super();
			
			Global.end = false;
			Global.endTimer = Global.END_TIME;
			
			Global.player = new PlayerGod();
			Global.camera.setFollow(Global.player);
			
			Global.hud = new Hud();
			Global.hud.setKey(Key.RIGHT);
			Global.hud.setKey(Key.UP);
			Global.hud.setKey(Key.DOWN);
			Global.hud.setKey(Key.LEFT);
			Global.hud.setKey(Key.X);
			Global.hud.setKey(Key.C);
			
			Global.friendsFollowing = 0;
			Global.goalFollowing = 1000;
			
			add(Global.player);
			add(Global.hud);
			add(new StarBackground());
			
			_white = addGraphic(Image.createRect(FP.width, FP.height, 0xFFFFFF, 0), -9999);
			
			_timer = 100;
		}
		
		override public function update():void
		{
			if (!Global.end)
			{
				if (_timer <= 0)
				{
					create(EnemyPlanet);
					_timer = 50;
				}
				else
					_timer--;
			}
			
			if (Global.friendsFollowing >= Global.goalFollowing)
				Global.end = true;
				
			if (Global.end)
			{
				_white.x = Global.camera.x;
				_white.y = Global.camera.y;
				
				if (Global.endTimer <= 0)
					FP.world = new EndWorld();
				else if (Global.endTimer <= 30)
				{
					(_white.graphic as Image).alpha += 0.1;
					Global.endTimer--;
				}
				else
					Global.endTimer--;
			}
			
			super.update();
			
			Global.camera.update();
		}
		
	}

}