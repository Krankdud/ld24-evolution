package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class PlayerFireball extends BaseEntity
	{
		
		public function PlayerFireball() 
		{
			super(0, 0, Image.createRect(16, 16, 0xFF9900));
			setHitbox(16, 16);
			layer = 1;
			type = "playerfire";
		}
		
		override public function update():void
		{
			if (x < Global.camera.x - FP.width || x > Global.camera.x + FP.width + FP.width
				|| y < Global.camera.y - FP.width || y > Global.camera.y + FP.height + FP.width)
			{
				FP.world.recycle(this);
			}
			
			super.update();
		}
		
	}

}