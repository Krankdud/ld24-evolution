package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;

	public class Particle extends BaseEntity
	{
		protected var timer:int;
		protected var lifeTime:int;
		
		public function Particle(x:int = 0, y:int = 0, graphic:Graphic = null, mask:Mask = null) 
		{
			super(x, y, graphic, mask);
			
			collideWithSolids = false;
		}
		
		override public function added():void
		{
			timer = lifeTime;
		}
		
		override public function update():void
		{
			if (timer < 0)
				FP.world.recycle(this);
			timer--;
			
			super.update();
		}
		
	}

}