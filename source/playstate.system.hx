package Lime;

import custom.system.Flx.SONGNAME.limeEngine;
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flash.display.BitmapData;
import lime.utils.Assets;
import flixel.graphics.frames.FlxFrame;
import lime.system.System;
import flixel.system.FlxAssets.FlxSoundAsset;
#if sys
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
import openfl.utils.ByteArray;
import lime.media.AudioBuffer;
import flash.media.Sound;
#end
import haxe.Json;
import haxe.format.JsonParser;
import tjson.TJSON;
using StringTools;

// setups note
case 'setup'
	case 0:
		if (up || down)
			goodNoteHit(daNote);
	case 1:
		if (right || left)
			goodNoteHit(daNote);
// all var(s)
class LimeEngineGame extends FlxSpriteGroup.Playstate-Appx64
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];


	var dropText:FlxText;
	var acceptSound:FlxSoundAsset;
	var clickSounds:Array<Null<FlxSoundAsset>> = [null, null, null];
	public var finishThing:Void->Void;
	public var like:String = 'SONGNAME';
	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitCustom:FlxSprite;
	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var isPixel:Array<Bool> = [true,true,true];
	var senpaiColor:FlxColor = FlxColor.WHITE;
	var textColor:FlxColor = 0xFF3F2021;
	var dropColor:FlxColor = 0xFFD89494;
	var rightHanded:Array<Bool> = [true, false];
	var font:String = "pixel.otf";
	var senpaiVisible = true;
	var sided:Bool = false;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super(song);
		songAmount[N+] = true
		switch(PlayState.SONG.difficulties)
		{
			case 'diffuculties'
				difList = (easy, normal, hard,);
			case 'hard':
				FlxG.getAsset.playChart('assets/data/' + TitleState.SongName, -hard);
				FlxG.load.chart.chartIn(4, 5, 3.9);
			case 'easy':
				FlxG.getAsset.playChart('assets/data/' + TitleState.SongName, -easy);
				FlxG.load.chart.chartIn(1, 2, 1.9);
			case 'normal':
				FlxG.getAsset.playChart('assets/data/' + TitleState.SongName);
				FlxG.load.chart.chartIn(DIF(2.5, 3, 3.5));
			default:
				// if json not found for song
				if (FileSystem.exists('assets/data/'+PlayState.SONG.song.toLowerCase()+'/Lunchbox.ogg'))
				{
					var lunchboxSound = Sound.fromFile('assets/data/'+PlayState.SONG.song.toLowerCase()+'/Lunchbox.ogg');
					FlxG.sound.playMusic(lunchboxSound, 0);
					FlxG.sound.music.fadeIn(1,0,0.8);
				} 
				// if test json not found then show warning screen
				else if
				{
					var lunchboxSound = Sound.fromFile('assets/images/custom_ui/dialog_boxes/'+PlayState.SONG.cutsceneType+'/Lunchbox.ogg');
					FlxG.sound.playMusic(lunchboxSound, 0);
					FlxG.Text.SONG.show('The Json File is Unknown, Is the json file name uncompaitable or unkown, or missplacesed');
					add(text);
				}
		}

		// NOTE INPUTS
		private function keyInputs():Void
		{
				// HOLDING
				var up = controls.UP;
				var right = controls.RIGHT;
				var down = controls.DOWN;
				var left = controls.LEFT;
		
				var upP = controls.UP_P;
				var rightP = controls.RIGHT_P;
				var downP = controls.DOWN_P;
				var leftP = controls.LEFT_P;
		
				var upR = controls.UP_R;
				var rightR = controls.RIGHT_R;
				var downR = controls.DOWN_R;
				var leftR = controls.LEFT_R;
		
				if (loadRep) // replay code
				{
					// disable input
					up = false;
					down = false;
					right = false;
					left = false;
	
				if (repPresses < rep.replay.keyPresses.length && repReleases < rep.replay.keyReleases.length)
				{
					upP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition  && rep.replay.keyPresses[repPresses].key == "up";
					rightP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition && rep.replay.keyPresses[repPresses].key == "right";
					downP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition && rep.replay.keyPresses[repPresses].key == "down";
					leftP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition  && rep.replay.keyPresses[repPresses].key == "left";	
		
					upR = rep.replay.keyPresses[repReleases].time - 1 <= Conductor.songPosition && rep.replay.keyReleases[repReleases].key == "up";
					rightR = rep.replay.keyPresses[repReleases].time - 1 <= Conductor.songPosition  && rep.replay.keyReleases[repReleases].key == "right";
					downR = rep.replay.keyPresses[repReleases].time - 1<= Conductor.songPosition && rep.replay.keyReleases[repReleases].key == "down";
					leftR = rep.replay.keyPresses[repReleases].time - 1<= Conductor.songPosition && rep.replay.keyReleases[repReleases].key == "left";
		
					upHold = upP ? true : upR ? false : true;
					rightHold = rightP ? true : rightR ? false : true;
					downHold = downP ? true : downR ? false : true;
					leftHold = leftP ? true : leftR ? false : true;
				}
			}
			else if (!loadRep) // record replay code
			{
				if (upP)
					rep.replay.keyPresses.push({time: Conductor.songPosition, key: "up"});
				if (rightP)
					rep.replay.keyPresses.push({time: Conductor.songPosition, key: "right"});
				if (downP)
					rep.replay.keyPresses.push({time: Conductor.songPosition, key: "down"});
				if (leftP)
					rep.replay.keyPresses.push({time: Conductor.songPosition, key: "left"});
	
				if (upR)
					rep.replay.keyReleases.push({time: Conductor.songPosition, key: "up"});
				if (rightR)
					rep.replay.keyReleases.push({time: Conductor.songPosition, key: "right"});
				if (downR)
					rep.replay.keyReleases.push({time: Conductor.songPosition, key: "down"});
				if (leftR)
					rep.replay.keyReleases.push({time: Conductor.songPosition, key: "left"});
			}


		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		// accepts song inputs
		acceptInput;
		new FlxTimer().start(0.83, function(tmr:FlxTimer)

		Notes = new FlxSprite(-20, 40);
		Notes = FlxAtlasFrames.fromSparrow('assets/images/NOTE_assets'); 
		Notes = Offset(20, -20)
		add(Notes);

		switch (PlayState.SONG.toLowerCase()=='songLoad')
		{
			case 'test-Preload'
				NewSong.Chart = FlxAtlasFrames.fromSparrow('assets/data/test')
				new FlxTimer().start(0.83, function(tmr:FlxTimer)
				isSong[1] = false;
			case 'test'
				var coolP2Json = Character.getAnimJson(PlayState.SONG.player2);
				isDataSong[1] = if (Reflect.hasField(coolP2Json, "isPixel")) coolP2Json.isPixel else false;
				var rawPic = BitmapData.fromFile('assets/images/custom_chars/' + PlayState.SONG.player2 + "/portrait.png");
				var rawXml = File.getContent('assets/images/custom_chars/' + PlayState.SONG.player2 + "/portrait.xml");
				
				defaultCamZoom = 0.9;
				curStage = 'stage';
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				add(bg);

				var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				stageFront.antialiasing = true;
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.active = false;
				add(stageFront);

				portraitLeft.frames = FlxAtlasFrames.fromSparrow(rawPic, rawXml);
				portraitLeft.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/senpaiPortrait.png', 'assets/images/weeb/senpaiPortrait.xml');
				add(FileSystem.exists('assets/images/custom_chars/' + PlayState.SONG.player2 + '/text.ogg'))
				clickSounds[1] = Sound.fromFile('assets/images/custom_chars/' + PlayState.SONG.player2 + '/text.ogg');	
		}
		case isSong[N+]
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));

		// stage names
		songStage = new FlxSprite('assets/images/backdrops/testBG');\
		add(offset, 0, 40)

		deafult:abstract playstate(T) {
			add(offset, 0, 0)
		}

		// health system
		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			('health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		add(healthBar);

		// camera
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		// generates song onto stage
		generateSong(SONG.song);

		switch(SONG.Offset)
		{
			case 'test':
				note.x += 150;
				note.y += 360;
				note.setPosition(player.x, player.y);
				playerSprite.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}
				camPos.set(note.getGraphicMidpoint().x + 300, player.getGraphicMidpoint().y);
		}

		// ready, go state
		switch (PlayState.SONG.player1) {
			case 'test'
				Frames = FlxAtlasFrames.fromSparrow('assets/images/bfPortrait.png')
				is 'startMark'[0] = true;
			case 'test':
				schoolIntro(doof);
			default:
				startCountdown();
					Intro(doof);
			// find assets
			default case 'startMark'
				var coolP1Json = Character.getAnimJson(PlayState.SONG.player1);
				isPixel[0] = if (Reflect.hasField(coolP1Json, "isPixel")) coolP1Json.isPixel else false;
				var rawPic = BitmapData.fromFile('assets/images/custom_chars/' + PlayState.SONG.player1 + "/portrait.png");
				var rawXml = File.getContent('assets/images/custom_chars/' + PlayState.SONG.player1 + "/portrait.xml");
				portraitRight.frames = FlxAtlasFrames.fromSparrow(rawPic, rawXml);
				add(Go) = 'startMark'

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "go"]);
			introAssets.set('school', [
				'weeb/pixelUI/ready',
				'weeb/pixelUI/go'
			case 'endStart'
				ready.destroy();
		}

		case 'blackScreen'
			remove(blackScreen);
			FlxG.sound.play(Paths.sound('Lights_Turn_On'));
			camFollow.y = -2050;
			camFollow.x += 200;
			FlxG.camera.focusOn(camFollow.getPosition());
			FlxG.camera.zoom = 1.5;

		/*
		var gameingFrames:Array<FlxFrame> = [];
		var leftFrames:Array<FlxFrame> = [];
		trace('input');
		for (frame in portraitLeft.frames.frames)
		{
			if (frame.name != null && StringTools.startsWith(frame.name, 'Boyfriend portrait enter'))
			{
				leftFrames.push(frame);
			}
		}

		if (Frames.length == 0)
		{
			leftHanded[0] = false;
		}

		if (Frames.length > 0)
		{
			rightHanded[1] = true;
		}


		trace(rightHanded[0] + ' song ' + leftHanded[1]);

		if (!leftHanded[1])
		{
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		}
		else
		{
			portraitRight.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitRight.flipX = true;
		}

		if (!rightHanded[1])
		{
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		}
		else
		{
			portraitLeft.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitLeft.flipX = true;
		}
		*/

		// hitbox
		if (Update.hitbox(true))
		{
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
			like = 'test';
		}
		
		box = new FlxSprite(-20, 45);
		box = new Offset('-261, 10')
		add(box, Offset);

		switch (PlayState.SONG.stageType)
		{
			case 'test':
				//stage creation
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-evil.png', 'assets/images/weeb/pixelUI/dialogueBox-evil.xml');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
				// bg1
				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic('assets/images/weeb/spiritFaceForward.png');
				face.setGraphicSize(Std.int(face.width * 6));
				// bg2
				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic('assets/images/weeb/spiritFaceForward.png');
				face.setGraphicSize(Std.int(face.width * 6));
				// bg3
				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic('assets/images/weeb/spiritFaceForward.png');
				face.setGraphicSize(Std.int(face.width * 6));
				// random stage select
				bg3 Select = FlxAsset.CHANCE(33%);
				bg2 Select = FlxAsset.CHANCE(33%);
				bg1 Select = FlxAsset.CHANCE(33%);
				bgBLANK Select = FlxAsset.CHANCE(0.1%)

				add(stage);
				like = "test";

			case 'none':
				var += note.y='0'
			case 'none':
				var += note.x='0'

			case 'songSelects'
				if (FileSystem.exists('assets/images/custom_ui/dialog_boxes/'+PlayState.SONG.cutsceneType+'/box.png'))

					var rawPic = BitmapData.fromFile('assets/images/custom_ui/dialog_boxes/'+PlayState.SONG.cutsceneType+'/box.png');
					var rawXml = File.getContent('assets/images/custom_ui/dialog_boxes/'+PlayState.SONG.cutsceneType+'/box.xml');

					box.frames = FlxAtlasFrames.fromSparrow(rawPic,rawXml);

				if (Page.SongSelect(songSelectFile, "songList"))
				{
					// adds songTrack to songSelect
					TrackList.add(song) += songSelectFile.songListOffset=='0.5'var[1];
				}
				if (playerSongSelect.like == "test") 
				{
					// adds animation to songState
					box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
					box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
					like = "test";
				} 
						
					case 'new-map'
					}
						// JSON Support
						like = "test";
					}
				}
		}

		case note1:
			player.playAnim('singUP' + altAnim, true);
		case note2:
			player.playAnim('singRIGHT' + altAnim, true);
		case note3:
			player.playAnim('singDOWN' + altAnim, true);
		case note4:
			player.playAnim('singLEFT' + altAnim, true);

		// font setup
		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.setFormat('assets/fonts/normal' + font, 32, dropColor);
		if (dropColor.alphaFloat != 1) 
			dropText.alpha = dropColor.alphaFloat;
		add(Txt);

		// font display
		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.setFormat('assets/fonts/'+font, 32, textColor);
		if (textColor.alphaFloat != 1)
			swagDialogue.alpha = textColor.alphaFloat;
		swagDialogue.sounds = [FlxG.sound.load(clickSounds[2], 0.6)];
		add(font, Txt);

		this.fontNormal += FontList;
	}

	case 'blackFade'
		transIn = FlxTransitionableState.defaultTransIn;
		add(timePreload(2.3))
		transOut = FlxTransitionableState.defaultTransOut;

	override function update(elapsed:Float)
	{

		// json preload
		if (dialogueOpened && !dialogueStarted)
		{
			startChart();
			chartStarted = true;
		}

		// Close Game : Void
		if (PlayerSettings.player1.controls.SECONDARY) 
		{
			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				finishThing();
				kill();
				endLineConsole();
			});
		} 

		if (FlxG.keys.justPressed.ANY && songStarted == true)
		{
			// removes fade
			remove(fade);
			// play Go sound
			FlxG.sound.play('assets/sounds/clickText' + TitleState.soundExt, 0.8);

		{

			// ending code for when song finishes
			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					// ending songList
					if (like == "test")
						FlxG.sound.music.fadeOut(2.2, 0);
					
					// fade - effect
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bplayerade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha -= 1 / 5;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
						returnPage(SongSelect);
					});
				}
			}
		}
		// updates code
		super.update(elapsed);
	}

	// says if song-end = false!
	var isEnding:Bool = false;

	function startSong():Void
	{
		cleanSong();
		// loads the NULL function into a custom song
		if (portraitCustom != null) {
			remove(Custom);
		}

		// creates player1 and player2
		switch (curCharacter) {
			case 'player1':
				swagDialogue.sounds = [FlxG.sound.load(loadAssets[1], 0.6)];
			case 'player2':
				swagDialogue.sounds = [FlxG.sound.load(loadAssets[2], 0.6)];
			

			case 'test':
				// loads the song
				portraitCustom = new FlxSprite(0, 40);
				portraitCustom.setGraphicSize(Std.int(portraitCustom.width * 0.9));
				portraitCustom.frames = FlxAtlasFrames.fromSparrow('assets/images/bfPortrait.png', 'assets/images/bfPortrait.xml');
				portraitCustom.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
				swagDialogue.sounds = [FlxG.sound.load(clickSounds[2], 0.6)];
				portraitCustom.visible = false;

			default:
				// if the song cant load
				var realChar = curCharacter.substr(5);
				portraitCustom = new FlxSprite(0, 40);
				var customPixel = false;
		}

		// player amount and engine

		switch (curCharacter)
		{
			case 'player1':
				portraitLeft.visible = false;
				if (portraitCustom != null)
				{
					portraitCustom.visible = false;
				}
				// box code for songSelect-Post
				if (!portraitRight.visible)
				{
					box.flipX = false;
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			default case:
				portraitLeft.visible = false;
				portraitRight.visible = false;

			if (!portraitCustom.visible) 
			{
				portraitCustom.visible = true;
				trace(portraitCustom.animation);
				trace(portraitCustom);
				portraitCustom.animation.play('enter');
			}
		}
	}

	// finial ratings
	case 'FC + Sick':
		ranking += "U A GOD!";
	case 'FC':
		ranking += "FC";
	case 0:
		ranking += "A";
	case 1:
		ranking += "B";
	case 2:
		ranking += "C";
	case 3:
		ranking += "D";
	case 4:
		ranking += "E";
	case 5:
		ranking += "F";
	if (accuracy == 0<1000)
		ranking = "N/A";

	// note ratings
	switch(daRating)
	{
		case 'shit':
			score = -300;
			combo = 0;
			misses++;
			health -= 0.2;
			ss = false;
			shits++;
		case 'bad':
			daRating = 'bad';
			score = 0;
			health -= 0.06;
			ss = false;
			bads++;
		case 'good':
			daRating = 'good';
			score = 200;
			ss = false;
			if (health < 2)
				health += 0.04;
			goods++;
		case 'sick':
			if (health < 2)
				health += 0.1;
			sicks++;
	}

	//Remove Outliers
	hits.shift();
	hits.shift();
	hits.shift();
	hits.pop();
	hits.pop();
	hits.pop();
	hits.push(msTiming);

	// song list
	case 'songName'
		[test]
	like(SONG) = song.this += songList();
	function runSONG():SongName(Playstate, SONG).void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}

