package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;

	public class BullBackground extends Entity
	{
		private var _topleft:Stamp;
		private var _topmid:Stamp;
		private var _topright:Stamp;
		private var _bottomleft:Stamp;
		private var _bottommid:Stamp;
		private var _bottomright:Stamp;
		
		public function BullBackground() 
		{
			super();
			
			layer = 9999;
			
			_topleft = new Stamp(Resources.IMG_BULLBACKGROUND, 0, 0);
			_topmid = new Stamp(Resources.IMG_BULLBACKGROUND, 0, 0);
			_topright = new Stamp(Resources.IMG_BULLBACKGROUND, 0, 0);
			_bottomleft = new Stamp(Resources.IMG_BULLBACKGROUND, 0, 0);
			_bottommid = new Stamp(Resources.IMG_BULLBACKGROUND, 0, 0);
			_bottomright = new Stamp(Resources.IMG_BULLBACKGROUND, 0, 0);
			
			graphic = new Graphiclist(_topleft, _topright, _topmid, _bottomleft, _bottommid, _bottomright);
		}
		
		override public function update():void
		{
			// Silly calculations ahoy!
			_topleft.x = Global.camera.x - Global.camera.x % 256;
			_topleft.y = Global.camera.y - Global.camera.y % 256;
			_topmid.x = Global.camera.x - Global.camera.x % 256 + 256;
			_topmid.y = Global.camera.y - Global.camera.y % 256;
			_topright.x = Global.camera.x - Global.camera.x % 256 + 512 - ((Global.camera.x < 0) ? 768 : 0);
			_topright.y = Global.camera.y - Global.camera.y % 256;
			_bottomleft.x = Global.camera.x - Global.camera.x % 256;
			_bottomleft.y = Global.camera.y - Global.camera.y % 256 + 256 - ((Global.camera.y < 0) ? 512 : 0);;
			_bottommid.x = Global.camera.x - Global.camera.x % 256 + 256;
			_bottommid.y = Global.camera.y - Global.camera.y % 256 + 256 - ((Global.camera.y < 0) ? 512 : 0);;
			_bottomright.x = Global.camera.x - Global.camera.x % 256 + 512 - ((Global.camera.x < 0) ? 768 : 0);
			_bottomright.y = Global.camera.y - Global.camera.y % 256 + 256 - ((Global.camera.y < 0) ? 512 : 0);
		}
		
	}

}