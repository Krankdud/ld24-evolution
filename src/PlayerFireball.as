package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	public class PlayerFireball extends BaseEntity
	{
		
		private var _spritemap:Spritemap;
		
		public function PlayerFireball() 
		{
			super(0, 0);
			setHitbox(16, 16, 8, 8);
			layer = 1;
			type = "playerfire";
			
			_spritemap = new Spritemap(Resources.IMG_PLAYERFIREBALL, 16, 16);
			_spritemap.add("x", [0]);
			_spritemap.add("y", [1]);
			_spritemap.centerOrigin();
			graphic = _spritemap;
		}
		
		override public function added():void
		{
			if (speed.x != 0)
			{
				_spritemap.play("x");
				_spritemap.flipped = speed.x < 0;
			}
			else
			{
				_spritemap.play("y");
				_spritemap.scaleY = speed.y < 0 ? -1 : 1;
			}
		}
		
		override public function update():void
		{
			if (x < Global.camera.x - FP.width || x > Global.camera.x + FP.width + FP.width
				|| y < Global.camera.y - FP.width || y > Global.camera.y + FP.height + FP.width)
			{
				FP.world.recycle(this);
			}
			
			for (var i:int = 0; i < 3; i++)
			{
				var e:Entity = FP.world.create(ParticleFire);
				e.x = x;
				e.y = y;
				(e as BaseEntity).speed.x = speed.x;
				(e as BaseEntity).speed.y = speed.y;
			}
			
			super.update();
		}
		
	}

}