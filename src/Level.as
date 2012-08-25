package  
{
	import net.flashpunk.FP;
	
	public class Level
	{
		private const SECTOR_SIZE:int = 1024;
		private var _sectorArray:Array;
		
		public function Level() 
		{
			_sectorArray = new Array();
			for (var i:int = 0; i < 20; i++)
			{
				_sectorArray[i] = new Array();
				for (var j:int = 0; j < 20; j++)
				{
					_sectorArray[i][j] = 0;
				}
			}
			
			var x:int = FP.random * 20;
			var y:int = FP.random * 20;
			createSector(x, y)
			FP.world.add(new Player(x * SECTOR_SIZE + SECTOR_SIZE * 0.5, y * SECTOR_SIZE + SECTOR_SIZE * 0.5));
		}
		
		private function createSector(x:int, y:int):void
		{
			if (x < 0 || x >= 20 || y < 0 || y >= 20)
				return;
				
			FP.world.add(new Sector(x * SECTOR_SIZE, y * SECTOR_SIZE));
		}
		
	}

}