package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;

	public class BaseEntity extends Entity
	{
		protected var speed:Point;
		
		public function BaseEntity(x:int = 0, y:int = 0, graphic:Graphic = null, mask:Mask = null) 
		{
			super(x, y, graphic, mask);
			
			speed = new Point();
		}
		
		override public function update():void
		{
			if (speed.x != 0)
			{
				if (collide("solid", x + speed.x, y))
				{
					for (var i:int = 0; i < Math.abs(speed.x); i++)
					{
						if (collide("solid", x + FP.sign(speed.x), y))
						{
							speed.x = 0;
							break;
						}
						
						x += FP.sign(speed.x);
					}
				}
				else
					x += speed.x;
			}
			
			if (speed.y != 0)
			{
				if (collide("solid", x, y + speed.y))
				{
					for (i = 0; i < Math.abs(speed.y); i++)
					{
						if (collide("solid", x, y + FP.sign(speed.y)))
						{
							speed.y = 0;
							break;
						}
						
						y += FP.sign(speed.y);
					}
				}
				else
					y += speed.y;
			}
		}
		
	}

}