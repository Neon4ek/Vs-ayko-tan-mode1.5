package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		FlxG.sound.playMusic(Paths.music('CreditSong'), 0);
		FlxG.sound.music.fadeIn(1, 0, 0.7);

		#if MODS_ALLOWED
		//trace("finding mod shit");
		for (folder in Paths.getModDirectories())
		{
			var creditsFile:String = Paths.mods(folder + '/data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['Vs Ayko-tan Team'],
			['Myrick',     			 'myrick',			'Cool artist',											'https://www.youtube.com/channel/UCgBf1PGEsc2x-2tFreMTmgg',  'e7e8f0'],
			['Dinebon',     		 'dinebon',			'Main sick compositor',									'https://www.youtube.com/channel/UCa4en8_sdvJ230vwRnXnY9A',  'dee56b'],
			['Neon',     			 'GAYicon',			'Main programmer for mod',								'https://www.youtube.com/channel/UCAoXP48PAkYtB0MfTch_yhA',  '9194a2'],
			['ever1n',     			 'ever1n',			'Yo second sick compositor',							'',  														 '656565'],
			['Ayko-tan',     		 'ayko-tan',		'Top waifu',											'https://www.google.com/search?q=top+waifu&tbm=isch&ved=2ahUKEwiUwMDhi9L0AhVvxosKHaOkBBAQ2-cCegQIABAA&oq=top+wai&gs_lcp=CgNpbWcQARgAMgUIABCABDIECAAQHjIECAAQHjIECAAQHjIECAAQHjIECAAQHjIECAAQHjIECAAQHjIECAAQHjIECAAQHjoHCCMQ7wMQJzoECAAQGDoICAAQgAQQsQM6BAgAEEM6CwgAEIAEELEDEIMBOgcIABCxAxBDOgQIABATOggIABAFEB4QE1CZCVjvJ2C6LmgDcAB4AIAB1QGIAcIJkgEFMC44LjGYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=hYmvYdTpOe-MrwSjyZKAAQ&bih=977&biw=1857',  '6546ff'],
			['Ike',     		 	 'ayk',				'Voice actor for radio Shit and Piss',					'https://www.youtube.com/channel/UC58XrCG5H-mNymUm60buw6Q',  'ff675e'],
			[''],
			['Cover from mod'],
			['Tails get Trolled',	 'tails',			'Sick no villains',										'https://gamebanana.com/mods/320596',						 'e18e10'],
			['Dave and Bambi',	     'bambi',			'Well made Cheating',									'https://gamebanana.com/mods/43201',						 '23d63c'],
			['Shaggy mod',	     	 'shaggy',			'I dont want to make 9k gameplay',						'https://gamejolt.com/games/fnf-shaggy/643999',				 '800080'],
			[''],
			['Psych Engine Team'],
			['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',						'https://twitter.com/Shadow_Mario_',	'FFDD33'],
			['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',					'https://twitter.com/river_oaken',		'C30085'],
			['bb-panzu',			'bb-panzu',			'Additional Programmer of Psych Engine',				'https://twitter.com/bbsub3',			'389A58'],
			[''],
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",					'https://twitter.com/ninja_muffin99',	'F73838'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",						'https://twitter.com/PhantomArcade3K',	'FFBB1B'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",						'https://twitter.com/evilsk8r',			'53E52C'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",						'https://twitter.com/kawaisprite',		'6475F3']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("FolksXXHeavy.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(2, 0, 0.7);
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}