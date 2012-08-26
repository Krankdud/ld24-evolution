package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;

	public class EnemyCannonball extends BaseEntity
	{
		
		private var _spritemap:Spritemap;
		
		public function EnemyCannonball() 
		{
			super(0, 0);
			layer = 3;
			setHitbox(8, 4, 8, 4);
			type = "enemyfire";
			
			_spritemap = new Spritemap(Resources.IMG_ENEMYCANNONBALL, 12, 12);
			_spritemap.add("fire", [0, 1, 2], 0.3, false);
			_spritemap.centerOrigin();
			graphic = _spritemap;
		}
		
		override public function added():void
		{
			_spritemap.play("fire", true);
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