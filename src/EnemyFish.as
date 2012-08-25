package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class EnemyFish extends BaseEntity
	{
		private const THINK_TIME:int = 90;
		private const RUN_TIME:int = 180;
		
		private var _thinkTimer:int;
		private var _runTimer:int;
		
		private var _angle:int;
		
		private var _state:int;
		private var _target:Entity;
		
		public function EnemyFish() 
		{
			super(0, 0, Image.createRect(8, 8, 0xFF0000));
			setHitbox(8, 8);
			type = "enemy";
		}
		
		override public function added():void
		{
			x = Global.camera.x - 8 + Math.round(FP.random) * (FP.width + 16);
			y = Global.camera.y - 8 + Math.round(FP.random) * (FP.height + 16);
			
			_angle = 360 * FP.random;
			FP.angleXY(speed, _angle, 0.2);
			
			_state = 0;
			
			_thinkTimer = THINK_TIME;
			
			super.added();
		}
		
		override public function update():void
		{
			if (_state == 0)
			{
				if (_thinkTimer <= 0)
				{
					_target = FP.world.nearestToEntity("friend", this);
					_state = 1;
				}
				else
					_thinkTimer--;
			}
			else if (_state == 1)
			{
				if (_target != null && _target.active)
				{
					FP.angleXY(speed, FP.angle(x, y, _target.x, _target.y), 1);
				}
				else
				{
					_state = 0;
					_thinkTimer = THINK_TIME;
					
					_angle = 360 * FP.random;
					FP.angleXY(speed, _angle, 0.2);
				}
			}
			else if (_state == 2)
			{
				if (_runTimer <= 0)
				{
					_state = 0;
					_thinkTimer = THINK_TIME;
					
					_angle = 360 * FP.random;
					FP.angleXY(speed, _angle, 0.2);
				}
				else
				{
					_runTimer--;
					FP.angleXY(speed, FP.angle(x, y, Global.player.x, Global.player.y) + 180, 1.4);
				}
			}
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) < 32)
			{
				_state = 2;
				_runTimer = RUN_TIME;
			}
			
			if (FP.distance(x, y, Global.player.x, Global.player.y) > FP.width)
				FP.world.recycle(this);
				
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			
			super.update();
		}
		
	}

}