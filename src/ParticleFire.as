package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class ParticleFire extends Particle
	{
		
		public function ParticleFire() 
		{
			super(0, 0, Image.createRect(2, 2, 0xFF0000));
			(graphic as Image).centerOrigin();
			layer = 100;
			lifeTime = 10;
		}
		
		override public function added():void
		{
			super.added();
		}
		
		override public function update():void
		{
			speed.x += -0.5 + FP.random;
			speed.y += -0.5 + FP.random;
			
			super.update();
		}
		
	}

}