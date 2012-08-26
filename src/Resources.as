package  
{
    import net.flashpunk.Sfx;
    
    public class Resources 
    {
        [Embed(source = "data/graphics/bullbackground.png")] static public const IMG_BULLBACKGROUND:Class;
        [Embed(source = "data/graphics/critterbackground.png")] static public const IMG_CRITTERBACKGROUND:Class;
        [Embed(source = "data/graphics/dustbackground.png")] static public const IMG_DUSTBACKGROUND:Class;
        [Embed(source = "data/graphics/enemybattleship.png")] static public const IMG_ENEMYBATTLESHIP:Class;
        [Embed(source = "data/graphics/enemybull.png")] static public const IMG_ENEMYBULL:Class;
        [Embed(source = "data/graphics/enemycannonball.png")] static public const IMG_ENEMYCANNONBALL:Class;
        [Embed(source = "data/graphics/enemycritter.png")] static public const IMG_ENEMYCRITTER:Class;
        [Embed(source = "data/graphics/enemydust.png")] static public const IMG_ENEMYDUST:Class;
        [Embed(source = "data/graphics/enemyfire.png")] static public const IMG_ENEMYFIRE:Class;
        [Embed(source = "data/graphics/enemyfish.png")] static public const IMG_ENEMYFISH:Class;
        [Embed(source = "data/graphics/enemygiantcritter.png")] static public const IMG_ENEMYGIANTCRITTER:Class;
        [Embed(source = "data/graphics/friendbird.png")] static public const IMG_FRIENDBIRD:Class;
        [Embed(source = "data/graphics/friendbull.png")] static public const IMG_FRIENDBULL:Class;
        [Embed(source = "data/graphics/friendcritter.png")] static public const IMG_FRIENDCRITTER:Class;
        [Embed(source = "data/graphics/frienddust.png")] static public const IMG_FRIENDDUST:Class;
        [Embed(source = "data/graphics/friendfish.png")] static public const IMG_FRIENDFISH:Class;
        [Embed(source = "data/graphics/keys.png")] static public const IMG_KEYS:Class;
        [Embed(source = "data/graphics/planet.png")] static public const IMG_PLANET:Class;
        [Embed(source = "data/graphics/playerbull.png")] static public const IMG_PLAYERBULL:Class;
        [Embed(source = "data/graphics/playercritter.png")] static public const IMG_PLAYERCRITTER:Class;
        [Embed(source = "data/graphics/playerdragon.png")] static public const IMG_PLAYERDRAGON:Class;
        [Embed(source = "data/graphics/playerdust.png")] static public const IMG_PLAYERDUST:Class;
        [Embed(source = "data/graphics/playerfireball.png")] static public const IMG_PLAYERFIREBALL:Class;
        [Embed(source = "data/graphics/playerfish.png")] static public const IMG_PLAYERFISH:Class;
        [Embed(source = "data/graphics/playergod.png")] static public const IMG_PLAYERGOD:Class;
        [Embed(source = "data/graphics/ripple.png")] static public const IMG_RIPPLE:Class;
        [Embed(source = "data/graphics/starfield.png")] static public const IMG_STARFIELD:Class;
        [Embed(source = "data/graphics/sun.png")] static public const IMG_SUN:Class;
        [Embed(source = "data/graphics/sunray.png")] static public const IMG_SUNRAY:Class;
        [Embed(source = "data/graphics/titlecircle.png")] static public const IMG_TITLECIRCLE:Class;
        [Embed(source = "data/graphics/wave.png")] static public const IMG_WAVE:Class;
        [Embed(source = "data/sounds/batteshipshoot.mp3")] static public const SND_BATTESHIPSHOOT:Class;
        static public var sfxBatteshipshoot:Sfx = new Sfx(SND_BATTESHIPSHOOT);
        [Embed(source = "data/sounds/collect.mp3")] static public const SND_COLLECT:Class;
        static public var sfxCollect:Sfx = new Sfx(SND_COLLECT);
        [Embed(source = "data/sounds/critterland.mp3")] static public const SND_CRITTERLAND:Class;
        static public var sfxCritterland:Sfx = new Sfx(SND_CRITTERLAND);
        [Embed(source = "data/sounds/earthquake.mp3")] static public const SND_EARTHQUAKE:Class;
        static public var sfxEarthquake:Sfx = new Sfx(SND_EARTHQUAKE);
        [Embed(source = "data/sounds/evolve.mp3")] static public const SND_EVOLVE:Class;
        static public var sfxEvolve:Sfx = new Sfx(SND_EVOLVE);
        [Embed(source = "data/sounds/fireball.mp3")] static public const SND_FIREBALL:Class;
        static public var sfxFireball:Sfx = new Sfx(SND_FIREBALL);
        [Embed(source = "data/sounds/gamestart.mp3")] static public const SND_GAMESTART:Class;
        static public var sfxGamestart:Sfx = new Sfx(SND_GAMESTART);
        [Embed(source = "data/sounds/hit.mp3")] static public const SND_HIT:Class;
        static public var sfxHit:Sfx = new Sfx(SND_HIT);
        [Embed(source = "data/sounds/hitenemy.mp3")] static public const SND_HITENEMY:Class;
        static public var sfxHitenemy:Sfx = new Sfx(SND_HITENEMY);
        [Embed(source = "data/sounds/punchingplanets.mp3")] static public const SND_PUNCHINGPLANETS:Class;
        static public var sfxPunchingplanets:Sfx = new Sfx(SND_PUNCHINGPLANETS);
        [Embed(source = "data/sounds/sink.mp3")] static public const SND_SINK:Class;
        static public var sfxSink:Sfx = new Sfx(SND_SINK);
        
        public function Resources() 
        {
            
        }
        
    }

}