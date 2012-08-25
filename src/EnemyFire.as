package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class EnemyFire extends Entity
	{
		private const FIRE_TIME:int = 120;
		
		private var _timer:int;
		
		public function EnemyFire() 
		{
			super(0, 0, Image.createRect(6, 6, 0xFF9900));
			setHitbox(6, 6);
			layer = 15;
			type = "enemyfire";
		}
		
		override public function added():void 
		{
			_timer = FIRE_TIME;
		}
		
		override public function update():void
		{
			if (_timer <= 0)
				FP.world.recycle(this);
			else
				_timer--;
		}
		
	}

}