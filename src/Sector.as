package  
{
	import flash.geom.Point;
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
					sectorArray[i][j] = SOLID;
				}
			}
			
			// Draw in some circles
			var numCircles:int = 2 + Math.round(FP.random * 3);
			var circlePoints:Array = new Array();
			for (i = 0; i < numCircles; i++)
			{
				var radi:int = 6 + Math.round(FP.random * 12);
				circlePoints.push(new Point(8 + FP.random * (SECTOR_SIZE_TILES - 16), 8 + FP.random * (SECTOR_SIZE_TILES - 16)));
				fillCircle(sectorArray, EMPTY, (circlePoints[i] as Point).x, (circlePoints[i] as Point).y, radi);
			}
			
			// Connect the circles
			for (i = 1; i < numCircles; i++)
			{
				var w:int = 2 + Math.round(FP.random * 4);
				var x1:int = (circlePoints[i] as Point).x;
				var x2:int = (circlePoints[i - 1] as Point).x;
				var y1:int = (circlePoints[i] as Point).y;
				var y2:int = (circlePoints[i - 1] as Point).y;
				if ((circlePoints[i - 1] as Point).x < (circlePoints[i] as Point).x)
				{
					x1 = (circlePoints[i - 1] as Point).x;
					x2 = (circlePoints[i] as Point).x;
				}
				if ((circlePoints[i - 1] as Point).y < (circlePoints[i] as Point).y)
				{
					y1 = (circlePoints[i - 1] as Point).y;
					y2 = (circlePoints[i] as Point).y
				}
				
				fillRect(sectorArray, EMPTY, x1, y1 - w * 0.5, x2 - x1, w);
				fillRect(sectorArray, EMPTY, x2 - w * 0.5, y1, w, y2 - y1);
			}
			
			// Throw in some random solid objects
			for (i = 0; i < SECTOR_SIZE_TILES; i++)
			{
				for (j = 0; j < SECTOR_SIZE_TILES; j++)
				{
					if (i == 0 || i == SECTOR_SIZE_TILES - 1 || j == 0 || j == SECTOR_SIZE_TILES - 1)
						sectorArray[i][j] = SOLID;
					
					if (sectorArray[i][j] == EMPTY && FP.random < 0.02)
						sectorArray[i][j] = SOLID;
				}
			}
			
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
		
		private function fillRect(array:Array, content:int, x:uint, y:uint, w:uint, h:uint):void
		{
			for (var i:int = 0; i < w; i++)
			{
				for (var j:int = 0; j < h; j++)
				{
					if (x + i < SECTOR_SIZE_TILES && y + j < SECTOR_SIZE_TILES)
						array[x + i][y + j] = content;
				}
			}
		}
		
		private function fillCircle(array:Array, content:int, x:uint, y:uint, radius:uint):void
		{
			for (var i:int = 1; i < radius * 2; i++)
			{
				for (var j:int = 1; j < radius * 2; j++)
				{
					if (x - radius + i >= 0 && x - radius + i < SECTOR_SIZE_TILES && y - radius + j >= 0 && y - radius + j < SECTOR_SIZE_TILES)
					{
						if ((x - (x - radius + i)) * (x - (x - radius + i)) + (y - (y - radius + j)) * (y - (y - radius + j)) <= radius * radius)
						{
							array[x - radius + i][y - radius + j] = content;
						}
					}
				}
			}
		}
		
	}

}