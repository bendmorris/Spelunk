package com.matttuttle.entities;

import haxepunk.HXP;
import haxepunk.Entity;
import haxepunk.graphics.Image;
import haxepunk.graphics.text.BitmapText;
import haxepunk.utils.Color;
import haxepunk.math.Vector2;
import haxepunk.math.Rectangle;

class HitPointText extends Entity
{

	private var dead:Bool;

	public function new(x:Float, y:Float, damage:Int)
	{
		var text:String;
		var textY:Int;

		super(x, y);
		text = Std.string(damage);
		var c:Color;
		if (damage >= 0)
		{
			text = "-" + text;
			textY = 0;
			c = 0xff0000;
		}
		else
		{
			textY = 5;
			c = 0x00ff00;
		}

		graphic = new BitmapText(text, 0, 0, 0, 0, {size: 8});
		graphic.color = c;
		_timer = kLife;
	}

	public override function update()
	{
		if (dead)
		{
			scene.remove(this);
			return;
		}

		y -= 2;
		_timer -= HXP.elapsed;
		graphic.alpha = _timer / kLife;
		if (_timer < 0)
			dead = true;

		super.update();
	}

	private var _timer:Float;
	private static inline var kLife:Float = 0.6;

}
