package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class EnemyBattleship extends BaseEntity
	{
		private const FIRE_TIME:int = 100;
		private var _fireTimer:int;
		private var _aiming:Boolean;
		
		private var _image:Image;
		
		public function EnemyBattleship() 
		{
			super(0, 0);
			setHitbox(16, 16, 8, 8);
			layer = 10;
			
			_image = new Image(Resources.IMG_ENEMYBATTLESHIP);
			_image.centerOrigin();
			graphic = _image;
		}
		
		override public function added():void
		{
			x = Global.camera.x - 8 + Math.round(FP.random) * (FP.width + 16);
			y = Global.camera.y - 8 + Math.round(FP.random) * (FP.height + 16);
			
			_aiming = false;
			_fireTimer = FIRE_TIME;
			
			super.added();
		}
		override public function update():void
		{
			FP.angleXY(speed, FP.angle(centerX, centerY, Global.player.centerX, Global.player.centerY), 0.5);
			
			if (_aiming && !Global.end)
			{
				if (_fireTimer <= 0)
				{
					var e:Entity = FP.world.create(EnemyCannonball);
					e.x = centerX;
					e.y = centerY;
					FP.angleXY((e as BaseEntity).speed, FP.angle(centerX, centerY, Global.player.centerX, Global.player.centerY), 3);
					_fireTimer = FIRE_TIME;
				}
				else
					_fireTimer--;
			}
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) < 120)
				_aiming = true;
			else
				_aiming = false;
				
			var c:Entity = collide("playerfire", x, y);
			if (c)
			{
				FP.world.recycle(c);
				FP.world.recycle(this);
			}
				
			if (FP.distance(x, y, Global.player.x, Global.player.y) > FP.width)
				FP.world.recycle(this);
				
			_image.flipped = speed.x < 0;
			
			super.update();
		}
		
	}

}