params [ "_sector", "_side" ];

active_sectors pushback _sector;
publicVariable "active_sectors";

sleep 20;
private _ownership = [markerpos _sector] call F_sectorOwnership;
if (_ownership == _side) then {
	diag_log format ["Spawn Attack Sector %1 by side %2 at %3", _sector, _side, time];

	private _sector_oldside = GRLIB_side_enemy;
	if (_sector in west_sectors) then { _sector_oldside = GRLIB_side_west};
	if (_sector in east_sectors) then { _sector_oldside = GRLIB_side_east};

	private _grp = grpNull;
	if ( GRLIB_blufor_defenders ) then {
		private _squad_type = [];
		private _squad_count = 8;

		if (_sector_oldside == GRLIB_side_west) then {
			_squad_type = squad_inf_light_west;
			if ( _sector in (sectors_military + sectors_bigtown)) then {
				_squad_type = squad_inf_west;
				_squad_count = 12;
			};
		};
		
		if (_sector_oldside == GRLIB_side_east) then {
			_squad_type = squad_inf_light_east;
			if ( _sector in (sectors_military + sectors_bigtown)) then {
				_squad_type = squad_inf_east;
				_squad_count = 12;
			};
		};

		_grp = createGroup [_sector_oldside, true];

		for "_i" from 1 to _squad_count do {	
			_unit = _grp createUnit [(selectRandom _squad_type), markerpos _sector, [], 80, "NONE"];
			_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			_unit setSkill 0.65;
			_unit setSkill ["courage", 1];
			_unit allowFleeing 0;
		};

		_grp setCombatMode "GREEN";
		_grp setBehaviour "COMBAT";
		sleep 1;
	};

	private _sector_timer = GRLIB_vulnerability_timer;
	if (_sector in sectors_bigtown) then {
		_sector_timer = _sector_timer + (10 * 60);
	};

	[_sector, 1, _sector_oldside, _sector_timer] remoteExec ["remote_call_sector", 0];

	_sector_timer = round (time + _sector_timer);
	private _enemycount = 8;
	private _has_players = true;

	while {( (time < _sector_timer || _has_players) && _enemycount >= 1 )} do {
		_has_players = (count ([getmarkerpos _sector, (GRLIB_capture_size * 2)] call F_getNearbyPlayers) > 0);
		_enemycount = [markerPos _sector, (GRLIB_capture_size * 2), _side] call F_getUnitsCount;
		sleep 3;
	};

	if ( GRLIB_endgame == 0 ) then {
		_ownership = [markerPos _sector, (GRLIB_capture_size * 2)] call F_sectorOwnership;
		if (_ownership != _sector_oldside && _ownership != GRLIB_side_civilian) then {
			diag_log format ["End Attack Sector %1 captured by %2 from %3", _sector, _ownership, _sector_oldside];
			if (_ownership == GRLIB_side_west) then {
				west_sectors = west_sectors + [ _sector ];
				[ _sector, 0, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
				stats_sectors_liberated = stats_sectors_liberated + 1;
			};

			if (_ownership == GRLIB_side_east) then {
				east_sectors = east_sectors + [ _sector ];
				[ _sector, 0, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
				stats_sectors_liberated = stats_sectors_liberated + 1;
			};

			if (_sector_oldside == GRLIB_side_west) then {
				west_sectors = west_sectors - [ _sector ];
				[ _sector, 2, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
				stats_sectors_lost = stats_sectors_lost + 1;
			};

			if (_sector_oldside == GRLIB_side_east) then {
				east_sectors = east_sectors - [ _sector ];
				[ _sector, 2, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
				stats_sectors_lost = stats_sectors_lost + 1;
			};
			publicVariable "west_sectors";
			publicVariable "east_sectors";
			[] call recalculate_caps;
			[] spawn check_victory_conditions;
		} else {
			[ _sector, 3, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
			//[ _sector, 3, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
			//{ [_x] spawn prisonner_ai; } foreach ( (getmarkerpos _sector) nearEntities [ ["Man"], GRLIB_capture_size * 0.8 ] );
		};
	};

	sleep 60;
	if ( GRLIB_blufor_defenders ) then {
		{ if ( alive _x ) then { deleteVehicle _x } } foreach units _grp;
	};
};

active_sectors = active_sectors - [ _sector ];
publicVariable "active_sectors";
diag_log format ["End Attack Sector %1 by side %2 at %3", _sector, _side, time];
