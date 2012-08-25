package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;

	public class EnemyGiantCritterShadow extends Entity
	{
		
		public function EnemyGiantCritterShadow(x:int) 
		{
			super(x, FP.height - 64, Image.createRect(128, 2, 0x000000, 0.5));
			layer = -1;
		}
		
	}

}