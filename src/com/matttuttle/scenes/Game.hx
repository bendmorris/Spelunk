package com.matttuttle.scenes;

import haxepunk.HXP;
import haxepunk.Scene;
import com.matttuttle.Bounds;
import com.matttuttle.entities.Exit;
import com.matttuttle.entities.Room;
import com.matttuttle.entities.Player;

class Game extends Scene
{
	public function new()
	{
		haxepunk.pixel.PixelArtScaler.globalActivate();

		super();
		_player = new Player("gfx/player/boy_white.png", 512, 328);
		add(_player);

		_room = new Room(_player);
		add(_room);
	}

	public override function begin()
	{
		_room.load("camp_room_1");
		// Starts player at location
		if (_room.start != null)
		{
			_player.x = _room.start.x;
			_player.y = _room.start.y;
		}
	}

	public override function update()
	{
		super.update();

		checkExits(); // must be after update and before camera move
		moveCamera();
	}

	public function checkExits()
	{
		var entrance:Exit, exit:Exit;
		var tid:String;
		var direction:Collision = _room.exitBounds.check(_player.x, _player.y);
		if (direction == NONE) return;

		entrance = cast _player.collide("exit", _player.x, _player.y);
		if (entrance == null)
		{
			_player.kill();
			return;
		}
		else
		{
			tid = _room.mapID;
			_room.load(entrance.destination);
			exit = _room.findExit(tid);
		}

		if (exit == null)
		{
			trace("Exit doesn't exist for " + tid);
			return;
		}

		switch(direction)
		{
			case LEFT:
				_player.x = _room.width - 4;
				_player.y += exit.y - entrance.y;
			case RIGHT:
				_player.x = 4;
				_player.y += exit.y - entrance.y;
			case TOP:
				_player.x += exit.x - entrance.x;
				_player.y = _room.height - 4;
			case BOTTOM:
				_player.x += exit.x - entrance.x;
				_player.y = 0;
			default:
				return;
		}
	}

	public function moveCamera()
	{
		// Set camera on x-axis
		camera.x = Std.int(_player.x - HXP.width / 2 + _player.halfWidth);

		// Set camera on y-axis
		camera.y = Std.int(_player.y - HXP.height / 2 + _player.halfHeight);

		_room.levelBounds.camera();
	}

	public static var player(get, null):Player;
	private static function get_player():Player { return _player; }

	private var _room:Room;
	private static var _player:Player;

}
