package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class FriendCritter extends BaseEntity
	{
		private const SINE:Array = new Array(0, 0.383, 0.707, 0.924, 1, 0.924, 0.707, 0.383, 0, -0.383, -0.707, -0.924, -1, -0.924, -0.707, -0.383);
		private const DROP_TIME:int = 5;
		private const MOVE_TIME:int = 80;
		private const SPEED:int = 3;
		
		private var _dropState:Boolean;
		private var _dropSinePos:int;
		private var _dropTimer:int
		
		private var _moveTimer:int;
		
		private var _follow:Boolean;
		
		public function FriendCritter() 
		{
			super(0, 0, Image.createRect(8, 8, 0x00FF00));
			setHitbox(8, 7);
			
			layer = 100;
			
			type = "friend";
		}
		
		override public function added():void
		{
			x = 10 + FP.random * (FP.width - 20);
			y = -12;
			
			_dropState = true;
			_dropSinePos = FP.random * SINE.length;
			_dropTimer = DROP_TIME;
			
			_moveTimer = MOVE_TIME;
			speed.y = 0.6;
		}
		
		override public function update():void
		{
			if (_dropState)
			{
				if (_dropTimer <= 0)
				{
					_dropSinePos = (_dropSinePos + 1 >= SINE.length) ? 0 : _dropSinePos + 1;
					speed.x = SINE[_dropSinePos];
					_dropTimer = DROP_TIME;
				}
				else
					_dropTimer--;
					
				if (collide("solid", x, y + speed.y))
				{
					speed.x = 0;
					_dropState = false;
				}
			}
			else
			{
				if (!_follow)
				{
					if (_moveTimer <= 0)
					{
						speed.x = (FP.random < 0.5) ? SPEED : -SPEED;
						_moveTimer = MOVE_TIME;
					}
					else
						_moveTimer--;
				}
				else
				{
					if (x < Global.player.x)
						speed.x += 0.2;
					else
						speed.x -= 0.2;
						
					speed.x = FP.clamp(speed.x, -2, 2);
				}
				
				if (!_follow)
				{
					if (speed.x > 0.1)
						speed.x -= 0.2;
					else if (speed.x < -0.1)
						speed.x += 0.2;
					else
						speed.x = 0;
				}
				
				if (collide("player", x + speed.x, y) && !_follow)
				{
					_follow = true;
					Global.friendsFollowing++;
				}
			}
			
			var e:Entity = FP.world.create(ParticleTrail);
			e.x = centerX;
			e.y = centerY;
			
			super.update();
		}
		
	}

}