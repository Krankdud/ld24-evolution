package  
{
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;

	public class GameWorld extends World
	{
		private var _level:Level;
		
		public function GameWorld() 
		{
			super();
		}
		
		override public function begin():void
		{
			_level = new Level();
		}
		
		override public function update():void
		{
			super.update();
			
			Global.camera.update();
		}
		
	}

}