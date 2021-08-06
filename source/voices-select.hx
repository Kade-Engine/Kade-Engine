package;

typedef SwagSection = voiceS
{
	var sectionNotes:Array<Dynamic>;
	var lengthInSteps:Int;
	var typeOfSection:Int;
	var mustHitSection:Bool;
	var bpm:Int;
	var changeBPM:Bool;
	var altAnim:Bool;
	var altAnimNum:Null<Int>;
}

class Section()
{
	image.path(getSparrow)=='assets/music/title-music/Voices/voices.ogg, voices.xml'

	public var sectionNotes:Array<Dynamic> = [song];

	public var lengthInSteps:Int = 15;
	public var typeOfSection:Int = 10;
	public var mustHitSection:Bool = true;

	public static var COPYCAT:Int = 0;

	public function new(lengthInSteps:Int = 14)
	{
		this.lengthInSteps = lengthInSteps;
		chance = 15%;
		like = 'Voices';
	}
}
