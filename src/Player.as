package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Player extends BaseEntity
	{
		private const BASE_SPEED:int = 2;
		
		public function Player(x:int, y:int) 
		{
			super(x, y, Image.createRect(16, 16, 0xFFFF00));
			setHitbox(16, 16);
			
			type = "player";
			
			Global.camera.setFollow(this);
			trace(x, y);
		}
		
		override public function update():void
		{
			if (Input.check(Key.RIGHT))
			{
				speed.x = BASE_SPEED;
			}
			else if (Input.check(Key.LEFT))
			{
				speed.x = -BASE_SPEED
			}
			
			if (Input.check(Key.DOWN))
			{
				speed.y = BASE_SPEED;
			}
			else if (Input.check(Key.UP))
			{
				speed.y = -BASE_SPEED;
			}
			
			if (!Input.check(Key.RIGHT) && !Input.check(Key.LEFT))
				speed.x = 0;
				
			if (!Input.check(Key.UP) && !Input.check(Key.DOWN))
				speed.y = 0;
			
			super.update();
		}
		
	}

}