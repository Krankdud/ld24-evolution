package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class EnemyPlanet extends BaseEntity
	{
		private const COLORS:Array = new Array(0x7d9eff, 0xffb6b6, 0xdfff7d, 0xffdf7d, 0xbe7dff);
		private const PUNCH_SPEED:int = 8;
		
		private var _image:Image;
		
		public function EnemyPlanet() 
		{
			super(0, 0);
			setHitbox(64, 64, 32, 32);
			layer = 80;
			
			_image = new Image(Resources.IMG_PLANET);
			_image.centerOrigin();
			graphic = _image;
			
			collideWithSolids = false;
			type = "solid";
		}
		
		override public function added():void
		{
			x = Global.camera.x - 64 + Math.round(FP.random) * (FP.width + 128);
			y = Global.camera.y - 64 + Math.round(FP.random) * (FP.height + 128);
			
			speed.x = 0;
			speed.y = 0;
			
			//_image.color = COLORS[Math.floor(5 * FP.random)];
			_image.color = 0x888888 + 0x777777 * FP.random;
		}
		
		public function punched(right:Boolean):void
		{
			speed.x = right ? PUNCH_SPEED : -PUNCH_SPEED;
			speed.y = -2 + FP.random * 4;
			
			var spirits:int = 20 + FP.random * 80;
			for (var i:int = 0; i < spirits; i++)
			{
				var e:Entity = FP.world.create(FriendSpirit);
				e.x = centerX;
				e.y = centerY;
			}
		}
		
		override public function update():void
		{
			if (x < Global.camera.x - 256 || x > Global.camera.x + FP.width + 256
				|| y < Global.camera.y - 256 || y > Global.camera.y + FP.height + 256)
			{
				FP.world.recycle(this);
			}
			
			super.update();
		}
		
	}

}