package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class Camera 
	{		
		private var _follow:Entity;
		public var x:int;
		public var y:int;
		
		public function Camera() 
		{
			x = 0;
			y = 0;
		}
		
		public function update():void
		{
			if (_follow)
			{
				x = _follow.centerX - FP.halfWidth;
				y = _follow.centerY - FP.halfHeight;
			}
			
			FP.camera.x = x;
			FP.camera.y = y;
		}
		
		public function setFollow(entity:Entity):void
		{
			_follow = entity;
		}
		
	}

}