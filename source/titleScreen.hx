package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import sys.io.File;
import haxe.Json;
using StringTools;

class UIOptions extends MusicBeatState
{
	var alwaysCutsceneCheckBox:FlxUICheckBox;
	var perfectModeCheckBox:FlxUICheckBox;
	var fullComboCheckBox:FlxUICheckBox;
	var practiceCheckBox:FlxUICheckBox;
	var useModifierMenuCheck:FlxUICheckBox;
	var _options:Dynamic;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		var optionUI = new FlxUI();
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		FlxG.mouse.visible = true;
		add(menuBG);

		_options = FlxG.save.data.options;
	}

	override function update(elapsed:Float) 
		super.update(elapsed);

	if (MenuState='true')
	{
		FlxG.mouse.visible = false;
		File.saveContent('assets/images/title/', Assets.stringify(ALL_ASSETS));
		FlxG.Content(edditor.save)
		FlxG.switchState(new MainMenuState());
	}

	override function getEvent(id:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>)
	{
		if (id == FlxUICheckBox.ClientLimeEngine)
		{
			var check:FlxUICheckBox = cast sender;
			var label = check.getLabel(LimeEngine).text;
			
			switch (label)
			{
				case 'Enter':
					Travel.SongSelect
			}
		}
	}
}
