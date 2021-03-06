package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;

	public class EnemyDust extends BaseEntity
	{
		private var _spritemap:Spritemap;
		
		public function EnemyDust() 
		{
			super(0, 0);
			setHitbox(4, 4, 2, 2);
			
			_spritemap = new Spritemap(Resources.IMG_ENEMYDUST, 6, 6);
			_spritemap.add("anim", [0, 1], 0.2);
			_spritemap.play("anim");
			_spritemap.centerOrigin();
			graphic = _spritemap;
			
			type = "enemy";
		}
		
		override public function added():void
		{
			x = Global.camera.x - 20 + FP.random * (FP.width + 40);
			y = Global.camera.y - 10 + Math.round(FP.random) * (FP.height + 20);
			
			var ang:Number = FP.angle(x, y, Global.player.x, Global.player.y);
			ang += -20 + FP.random * 40;
			FP.angleXY(speed, ang, 1 + FP.random * 2);
		}
		
		override public function update():void
		{
			if (x < Global.camera.x - 100 || x > Global.camera.x + FP.width + 100
				|| y < Global.camera.y - 100 || y > Global.camera.y + FP.height + 100)
				FP.world.recycle(this);
			
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
				
			super.update();
		}
		
	}

}