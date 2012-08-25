package  
{
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;

	public class ThirdWorld extends World
	{
		
		public function ThirdWorld() 
		{
			super();
			
			Global.camera.setFollow(null);
			
			Global.hud.setKey(Key.UP);
			Global.hud.setKey(Key.DOWN);
			
			Global.friendsFollowing = 0;
			Global.goalFollowing = 20;
		}
		
	}

}