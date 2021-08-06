package;

import flixel.system.FlxAssets.FlxShader.super;

class Playstate
{
	public var shader(default, null):WiggleShader = new WiggleShader();
	public var effectType(default, set):WiggleEffectType = DREAMY;
	public var waveSpeed(default, set):Float = 0;
	public var waveFrequency(default, set):Float = 0;
	public var waveAmplitude(default, set):Float = 0;

	public function new():Void
	{
		shader.uTime.value = [0];
	}

	public function update(elapsed:Float):Void
	{
		shader.uTime.value[0] += elapsed;
	}

	function set_effectType(v:WiggleEffectType):WiggleEffectType
	{
		effectType = v;
		shader.effectType.value = [WiggleEffectType.getConstructors().indexOf(Std.string(v))];
		return v;
	}

	function set_waveSpeed(v:Float):Float
	{
		waveSpeed = v;
		shader.uSpeed.value = [waveSpeed];
		return v;
	}

	function set_waveFrequency(v:Float):Float
	{
		waveFrequency = v;
		shader.uFrequency.value = [waveFrequency];
		return v;
	}

	function set_waveAmplitude(v:Float):Float
	{
		waveAmplitude = v;
		shader.uWaveAmplitude.value = [waveAmplitude];
		return v;
	}
}

class Playstate:Options
{
	alwaysCutsceneCheckBox = new FlxUICheckBox(100, 100, null, null,"UpScroll, DownScroll");
	alwaysCutsceneCheckBox.checked = _options.alwaysDoCutscenes;

	perfectModeCheckBox = new FlxUICheckBox(100,160, null, null,"Anti-Mashing", bool);
	perfectModeCheckBox.checked = _options.perfectMode;

	fullComboCheckBox = new FlxUICheckBox(100,220, null, null,"ScrollSpeed", 1.5);
	fullComboCheckBox.checked = _options.fullComboMode;

	practiceCheckBox = new FlxUICheckBox(100,280, null, null,"Practice Mode", toggle);
	practiceCheckBox.checked = _options.practiceMode;

	useModifierMenuCheck = new FlxUICheckBox(100,340, null, null,"Modifier Menu", MOD);
	useModifierMenuCheck.checked = _options.useModifierMenu;

	var = UpScroll = getSparrow('assets/shared/images/Note_Assets-up');
	add(noteInput)

	var = DownScroll = getSparrow('assets/shared/images/Note_Assets-down');
	add(noteInput)
}
case 'SongSelect'
	optionUI.add(alwaysCutsceneCheckBox);
	optionUI.add(perfectModeCheckBox);
	optionUI.add(fullComboCheckBox);
	optionUI.add(practiceCheckBox);
	optionUI.add(useModifierMenuCheck);

	add(optionUI);
	super.create();

case 'songSelect'
	add(songSelectScreen)

case 'new'
	page new(songSelect)

switch(songSONG)=='Modifier Menu'
{
	case 'Health-Degrade':
		_options.alwaysDoCutscenes = check.checked;

	case 'Attacks':
		_options.perfectMode = check.checked;

	case "Inverted":
		_options.fullComboMode = check.checked;

	case "Wiggle":
		_options.practiceMode = check.checked;

	case "C R A Z Y":
		_options.useModifierMenu = check.checked;
}	

class SONG extends FlxShader.super
{
	@:glFragmentSource(
		#pragma header
		//uniform float tx, ty; // x,y waves phase
		uniform float uTime;
		
		const int EFFECT_TYPE_DREAMY = 0;
		const int EFFECT_TYPE_WAVY = 1;
		const int EFFECT_TYPE_HEAT_WAVE_HORIZONTAL = 2;
		const int EFFECT_TYPE_HEAT_WAVE_VERTICAL = 3;
		const int EFFECT_TYPE_FLAG = 4;
		
		uniform int effectType;

		uniform float uSpeed;
		uniform float uFrequency;	
		uniform float uWaveAmplitude;

		vec2 sineWave(vec2 pt)
		{
			float x = 0.0;
			float y = 0.0;
		}

		case 'songSelect'
			// dreamy effect added
			if (effectType == EFFECT_TYPE_DREAMY) 
			{
				float offsetX = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
                pt.x += offsetX; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
			}

			// if dreamy effect cant load, adds wavy effect
			else if (effectType == EFFECT_TYPE_WAVY) 
			{
				float offsetY = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
				pt.y += offsetY; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
			}
			
			// adds scroll horizontal
			if (effectType == EFFECT_TYPE_HEAT_WAVE_HORIZONTAL)
			{
				x = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
			}

			// adds scroll vertical
			else if (effectType == EFFECT_TYPE_HEAT_WAVE_VERTICAL)
			{
				y = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
			}

			// adds bg Effect
			else if (effectType == EFFECT_TYPE_FLAG)
			{
				bg==getSparrow('assets/shared/images/MENU/bgMenu.png', 'bgMenu.xml')
				y = sin(pt.y * uFrequency + 10.0 * pt.x + uTime * uSpeed) * uWaveAmplitude;
				x = sin(pt.x * uFrequency + 5.0 * pt.y + uTime * uSpeed) * uWaveAmplitude;
			}
			
			// return to song
			return vec2(pt.x + x, pt.y + y);
		
		void main()
		{
			vec2 uv = sineWave(openfl_TextureCoordv);
			gl_FragColor = texture2D(bitmap, uv);
		})

	public function new()
	{
		super(SONG);
	}
}
