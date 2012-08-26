package  
{
	import net.flashpunk.FP;
	
	public class ScreenShaker 
	{
		
		private var _time:int;
		
		public function ScreenShaker() 
		{
			_time = 0;
		}
		
		public function shake(time:int):void
		{
			_time = time;
		}
		
		public function update():void
		{
			if (_time > 0)
			{
				FP.screen.x = FP.random * 8;
				FP.screen.y = FP.random * 8;
				_time--;
			}
			else
			{
				FP.screen.x = 0;
				FP.screen.y = 0;
			}
		}
		
	}

}