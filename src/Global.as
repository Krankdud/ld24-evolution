package  
{

	public class Global 
	{
		static public const END_TIME:int = 300;
		
		static public var camera:Camera = new Camera();
		static public var hud:Hud = new Hud();
		static public var player:BaseEntity;
		static public var friendsFollowing:int;
		static public var goalFollowing:int;
		static public var end:Boolean;
		static public var endTimer:int;
		
		public function Global() 
		{
			
		}
		
	}

}