package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class Camera 
	{
		
		private var follow:Entity;
		
		public function Camera() 
		{
			
		}
		
		public function update():void
		{
			if (follow)
			{
				FP.camera.x = follow.centerX - FP.halfWidth;
				FP.camera.y = follow.centerY - FP.halfHeight;
			}
		}
		
		public function setFollow(entity:Entity):void
		{
			follow = entity;
		}
		
	}

}