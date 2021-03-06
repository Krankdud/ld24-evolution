package  
{
	import net.flashpunk.graphics.Image;

	public class ParticleTrail extends Particle
	{
		
		public function ParticleTrail() 
		{
			super(0, 0, Image.createRect(1, 1, 0xFFFFFF));
			layer = 100;
			lifeTime = 10;
		}
		
		public function setColor(color:uint):void
		{
			(graphic as Image).color = color;
		}
		
		override public function added():void
		{
			(graphic as Image).alpha = 1;
			
			super.added();
		}
		
		override public function update():void
		{
			(graphic as Image).alpha -= 0.1;
			
			super.update();
		}
		
	}

}