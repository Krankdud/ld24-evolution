package  
{
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;

	public class GameWorld extends World
	{
		private var _camera:Camera;
		private var _player:Player;
		
		public function GameWorld() 
		{
			super();
			
			_camera = new Camera();
			_player = new Player(128, 32);
			_camera.setFollow(_player);
			
			add(_player);
			addMask(new Hitbox(64, 64), "solid", 16, 16);
		}
		
		override public function update():void
		{
			super.update();
			
			_camera.update();
		}
		
	}

}