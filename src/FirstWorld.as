package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;
	import net.flashpunk.FP;

	public class FirstWorld extends World
	{
		private var _timer:int;
		private var _background:Entity;
		
		public function FirstWorld() 
		{
			super();
			
			Global.goalFollowing = 20;
			Global.end = false;
			Global.endTimer = Global.END_TIME;
			
			Global.player = new PlayerDust(0, 0);
			add(Global.player);
			add(Global.hud);
			
			_background = addGraphic(new Stamp(Resources.IMG_DUSTBACKGROUND), 9999);
		}
		
		override public function update():void
		{
			if (!Global.end)
			{
				if (_timer <= 0)
				{
					if (FP.random < 0.5)
						create(EnemyDust);
					else
						create(FriendDust);
					_timer = 20;
				}
				else
					_timer--;
			}
			
			if (Global.friendsFollowing >= Global.goalFollowing)
				Global.end = true;
				
			if (Global.end)
			{
				if (Global.endTimer <= 0)
					FP.world = new SecondWorld();
				else
					Global.endTimer--;
			}
			
			super.update();
			
			Global.camera.update();
			_background.x = Global.camera.x;
			_background.y = Global.camera.y;
		}
		
	}

}