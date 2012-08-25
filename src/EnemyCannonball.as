package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;

	public class EnemyCannonball extends BaseEntity
	{
		
		public function EnemyCannonball() 
		{
			super(0, 0, Image.createRect(8, 8, 0xAAAAAA));
			layer = 3;
			setHitbox(8, 8);
			type = "enemyfire";
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