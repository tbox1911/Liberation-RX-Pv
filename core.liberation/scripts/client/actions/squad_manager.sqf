
waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };

while { true } do {

	// If Squad
	private _my_squad = player getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then {

		_leader = leader _my_squad;
		_veh_player = vehicle player;
		_wPos = player getVariable ["my_squad_dest", nil];

		//get in
		if ( _veh_player != player && _leader distance2D player <= 15 && isNil "_wPos" ) then {
			{
				_cargo_seat_free = ( (fullCrew [_veh_player, "cargo", true] - fullCrew [_veh_player, "cargo", false]) +
									 (fullCrew [_veh_player, "Turret", true] - fullCrew [_veh_player, "Turret", false]) );

				if (vehicle _x != _veh_player && count _cargo_seat_free > 0 ) then {

					if (_cargo_seat_free select 0 select 1 == "cargo" ) then {
						_cargo_idx = _cargo_seat_free select 0 select 2;
						_x action ["getInCargo", _veh_player, _cargo_idx]
					};

					if (_cargo_seat_free select 0 select 1 == "Turret" ) then {
						_cargo_idx = _cargo_seat_free select 0 select 3 select 0;
						_x action ["getInTurret", _veh_player, [_cargo_idx]]
					};
					sleep 0.5;
				};
				if (vehicle _x == _x && count _cargo_seat_free == 0 ) then {
					_x doMove (getPos player);
				};
			} forEach units _my_squad;
		};

		//para drop
		if (_veh_player iskindof "Steerable_Parachute_F") then {
			{
				if ( vehicle _x != _x && !(vehicle _x iskindof "Steerable_Parachute_F") ) then {
					[_x, getPos _x] spawn paraDrop;
					sleep 0.3;
				};
			} forEach units _my_squad;
		};

		//get out
		if (_veh_player == player) then {
			{
				//group leaveVehicle vehicle
				if ( vehicle _x != _x && (getPosATL _x select 2) <= 5) then {
					_x action ["getOut", vehicle _x];
					unassignVehicle _x;
					commandGetOut _x;
					doGetOut _x;
					sleep 0.5;
				};
			} forEach units _my_squad;
		};

		//go Pos
		_wPos = player getVariable ["my_squad_dest", getPos player];
		if  (_leader distance2D _wPos > 10) then {
			_leader setUnitPos "UP";
			_leader setSpeedMode 'FULL';
			_leader doMove _wPos;
			_squad_grp = (units _my_squad - [_leader]);
			_squad_grp doFollow _leader;
		};

		_my_squad_order = player getVariable ["my_squad_order", nil];
		if (!isNil "_my_squad_order") then {
			if (_my_squad_order == "follow") then {
				_leader setPos (getPos _leader vectorAdd [([] call F_getRND), ([] call F_getRND), 1]);
				_leader doFollow player;
			};
			if (_my_squad_order == "move") then {_leader doMove _wPos};
			if (_my_squad_order == "stop") then {doStop _leader};

			_leader sideChat "Order Received !!";
			player setVariable ["my_squad_order", nil, true];
		};

		if (count (units _my_squad) == 0) then {
			player setVariable ["my_squad", nil, true];
			player setVariable ["my_squad_order", nil, true];
		};
	};
	sleep 5;
};
