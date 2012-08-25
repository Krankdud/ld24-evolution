package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;

	public class Sector extends Entity
	{
		private const SECTOR_SIZE:int = 1024;
		private const SECTOR_SIZE_TILES:int = 64;
		
		private const EMPTY:int = 0;
		private const SOLID:int = 1;
		
		private var _grid:Grid;
		private var _tilemap:Tilemap;
		
		public function Sector(x:int, y:int) 
		{
			super(x, y);
			type = "solid";
			layer = 1000;
			trace(x, y);
			
			_grid = new Grid(SECTOR_SIZE, SECTOR_SIZE, 16, 16, 0, 0);
			_tilemap = new Tilemap(Resources.IMG_AUTOTILE, SECTOR_SIZE, SECTOR_SIZE, 16, 16);
			
			_tilemap.color = 0xFF0000;
			
			mask = _grid;
			graphic = _tilemap;
			
			generateSector();
		}
		
		private function generateSector():void
		{
			var sectorArray:Array = new Array();
			for (var i:int = 0; i < SECTOR_SIZE_TILES; i++)
			{
				sectorArray[i] = new Array();
				for (var j:int = 0; j < SECTOR_SIZE_TILES; j++)
				{
					if (i == 0 || i == SECTOR_SIZE_TILES - 1 || j == 0 || j == SECTOR_SIZE_TILES - 1)
						sectorArray[i][j] = SOLID;
					else
						sectorArray[i][j] = EMPTY;
						
					//sectorArray[i][j] = SOLID;
				}
			}
			
			//TODO: Stuff in here that will generate the layout
			
			// Generate the grid and the tilemap
			for (i = 0; i < SECTOR_SIZE_TILES; i++)
			{
				for (j = 0; j < SECTOR_SIZE_TILES; j++)
				{
					_grid.setTile(i, j, sectorArray[i][j] == SOLID);
					
					if (sectorArray[i][j] == EMPTY)
					{
						var neighbors:int = 0;
						
						// Check right side
						if (i < SECTOR_SIZE_TILES - 1)
						{
							if (sectorArray[i + 1][j] == EMPTY)
								neighbors += 1;
						}
						// Check top side
						if (j > 0)
						{
							if (sectorArray[i][j - 1] == EMPTY)
								neighbors += 2;
						}
						// Check left side
						if (i > 0)
						{
							if (sectorArray[i - 1][j] == EMPTY)
								neighbors += 4;
						}
						// Check bottom side
						if (j < SECTOR_SIZE_TILES - 1)
						{
							if (sectorArray[i][j + 1] == EMPTY)
								neighbors += 8;
						}
						
						_tilemap.setTile(i, j, neighbors);
					}
				}
			}
		}
		
	}

}