package  
{
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;

	public class GameWorld extends World
	{
		
		public function GameWorld() 
		{
			super();
		}
		
		override public function update():void
		{
			super.update();
			
			Global.camera.update();
		}
		
	}

}