package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;

	public class EnemyFire extends Entity
	{
		private const FIRE_TIME:int = 120;
		
		private var _timer:int;
		private var _spritemap:Spritemap;
		
		public function EnemyFire() 
		{
			super();
			setHitbox(6, 6);
			layer = 15;
			type = "enemyfire";
			
			_spritemap = new Spritemap(Resources.IMG_ENEMYFIRE, 8, 12);
			_spritemap.add("fireasdf", [0, 1, 2], 0.2);
			_spritemap.play("fireasdf");
			_spritemap.x = -1;
			_spritemap.y = -5;
			graphic = _spritemap;
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