package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Key;

	public class Hud extends Entity
	{
		private var _graphiclist:Graphiclist;
		private var _follow:Text;
		private var _need:Text;
		
		private var _keyRight:Spritemap;
		private var _keyLeft:Spritemap;
		private var _keyUp:Spritemap;
		private var _keyDown:Spritemap;
		private var _keyZ:Spritemap;
		private var _keyX:Spritemap;
		private var _keyC:Spritemap;
		
		public function Hud() 
		{
			super();
			
			layer = -1000;
			
			_graphiclist = new Graphiclist();
			
			_follow = new Text("Following: 999999", 2, 2);
			var o:Object = new Object;
			o.align = "right"
			_need = new Text("Need: 999", FP.width - 86, 2, o);
			
			_graphiclist.add(_follow);
			_graphiclist.add(_need);
			
			_keyRight = new Spritemap(Resources.IMG_KEYS, 8, 8);
			_keyRight.add("off", [2]);
			_keyRight.add("on", [3]);
			_keyRight.x = 22;
			_keyRight.y = FP.height - 10;
			_keyRight.play("on");
			_keyLeft = new Spritemap(Resources.IMG_KEYS, 8, 8);
			_keyLeft.add("off", [4]);
			_keyLeft.add("on", [5]);
			_keyLeft.x = 2;
			_keyLeft.y = FP.height - 10;
			_keyLeft.play("off");
			_keyDown = new Spritemap(Resources.IMG_KEYS, 8, 8);
			_keyDown.add("off", [6]);
			_keyDown.add("on", [7]);
			_keyDown.x = 12;
			_keyDown.y = FP.height - 10;
			_keyDown.play("off");
			_keyUp = new Spritemap(Resources.IMG_KEYS, 8, 8);
			_keyUp.add("off", [8]);
			_keyUp.add("on", [9]);
			_keyUp.x = 12;
			_keyUp.y = FP.height - 20;
			_keyUp.play("off");
			_keyZ = new Spritemap(Resources.IMG_KEYS, 8, 8);
			_keyZ.add("off", [10]);
			_keyZ.add("on", [11]);
			_keyZ.x = 32;
			_keyZ.y = FP.height - 10;
			_keyZ.play("off");
			_keyX = new Spritemap(Resources.IMG_KEYS, 8, 8);
			_keyX.add("off", [12]);
			_keyX.add("on", [13]);
			_keyX.x = 42;
			_keyX.y = FP.height - 10;
			_keyX.play("off");
			_keyC = new Spritemap(Resources.IMG_KEYS, 8, 8);
			_keyC.add("off", [14]);
			_keyC.add("on", [15]);
			_keyC.x = 52;
			_keyC.y = FP.height - 10;
			_keyC.play("off");
			
			_graphiclist.add(_keyRight);
			_graphiclist.add(_keyLeft);
			_graphiclist.add(_keyDown);
			_graphiclist.add(_keyUp);
			_graphiclist.add(_keyZ);
			_graphiclist.add(_keyX);
			_graphiclist.add(_keyC);
			
			graphic = _graphiclist;
		}
		
		override public function update():void
		{
			_follow.text = "Following: " + Global.friendsFollowing.toString();
			_need.text = "Need: " + Global.goalFollowing.toString();
		}
		
		override public function render():void
		{
			x = Global.camera.x;
			y = Global.camera.y;
			
			super.render();
		}
		
		public function setKey(key:int, on:Boolean = true):void
		{
			var s:String = on ? "on" : "off";
			if (key == Key.RIGHT)
				_keyRight.play(s);
			else if (key == Key.LEFT)
				_keyLeft.play(s);
			else if (key == Key.DOWN)
				_keyDown.play(s);
			else if (key == Key.UP)
				_keyUp.play(s);
			else if (key == Key.Z)
				_keyZ.play(s);
			else if (key == Key.X)
				_keyX.play(s);
			else if (key == Key.C)
				_keyC.play(s);
		}
		
	}

}