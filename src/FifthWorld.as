package  
{
	import net.flashpunk.World;

	public class FifthWorld extends World
	{
		
		public function FifthWorld() 
		{
			super();
			
			Global.end = false;
			Global.endTimer = Global.END_TIME;
			
			Global.player = new PlayerDragon(0, 0);
			Global.camera.setFollow(Global.player);
			
			Global.hud = new Hud();
			Global.hud.setKey(Key.RIGHT);
			Global.hud.setKey(Key.UP);
			Global.hud.setKey(Key.DOWN);
			Global.hud.setKey(Key.LEFT);
			Global.hud.setKey(Key.X);
			Global.hud.setKey(Key.C);
			
			Global.friendsFollowing = 0;
			Global.goalFollowing = 20;
			
			add(Global.player);
			add(Global.hud);
		}
		
	}

}