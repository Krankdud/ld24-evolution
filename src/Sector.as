package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;

	public class Sector extends Entity
	{
		private const SECTOR_SIZE:int = 1024;
		
		public function Sector(x:int, y:int) 
		{
			super(x, y);
			type = "solid";
		}
		
		private function generateSector():void
		{
			
		}
		
	}

}