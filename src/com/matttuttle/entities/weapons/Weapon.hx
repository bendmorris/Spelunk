package com.matttuttle.entities.weapons;

import haxepunk.Entity;
import haxepunk.HXP;
import com.matttuttle.scenes.Game;
import com.matttuttle.entities.Physics;
import com.matttuttle.entities.enemies.Enemy;
import com.matttuttle.entities.Player;

class Weapon extends Physics
{

	public var attack:Int = 1;

	public function new(name:String)
	{
		super(0, 0);
		_player = Game.player;
		this.name = name;
		type = "weapon";
	}

	public var isUsing(get, null):Bool;
	private function get_isUsing():Bool { return false; }

	public function use(direction:Direction) { }

	public function reposition()
	{
		x = _player.x;
		y = _player.y;
	}

	private function hitEnemy():Bool
	{
		var e:Enemy = cast collide("enemy", x, y);
		if (e != null && !e.dead)
		{
			e.hurt(attack);
			_player.experience += e.experience;
			return true;
		}
		return false;
	}

	private var _player:Player;

}
