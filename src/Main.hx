import haxepunk.Engine;
import haxepunk.Graphic;
import haxepunk.HXP;

class Main extends Engine
{
	public function new()
	{
		super(210, 120, 60, false);
	}

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		Graphic.smoothDefault = false;
		Graphic.pixelSnappingDefault = true;

		HXP.scene = new com.matttuttle.scenes.Game();
	}

	public static function main()
	{
		new Main();
	}
}
