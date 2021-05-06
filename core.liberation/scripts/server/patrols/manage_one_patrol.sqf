params [ "_minimum_readiness", "_patrol_type", "_index" ];
private [ "_headless_client" ];

waitUntil {sleep 1; !isNil "west_sectors" };
waitUntil {sleep 1; !isNil "east_sectors" };
waitUntil {sleep 1; !isNil "combat_readiness" };

while { GRLIB_endgame == 0 } do {
	waitUntil { sleep 1; (count west_sectors >= 3 || count east_sectors >= 3) };
	waitUntil { sleep 1; combat_readiness >= (_minimum_readiness / GRLIB_difficulty_modifier); };

	sleep ((1 + floor(random 5)) * 60);

	while { [] call F_opforCap > GRLIB_patrol_cap || (diag_fps < 25.0) } do {
		sleep (30 + floor(random 30));
	};

	// while { (count sectors_allSectors - count west_sectors) < ((_index + 1) * 2) } do {
	// 	sleep (150 + floor(random 150));
	// };

	private _spawn_marker = "";
	while { _spawn_marker == "" } do {
		_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, true] call F_findOpforSpawnPoint;
		if ( _spawn_marker == "" ) then {
			sleep (150 + floor(random 150));
		};
	};

	private _grp = grpNull;
	private _sectorpos = [ getMarkerPos _spawn_marker, floor(random 100), random 360 ] call BIS_fnc_relPos;
	private _sector_spawn_pos = zeropos;
	while { _sector_spawn_pos distance zeropos < 100 } do {
		_sector_spawn_pos = ( [ _sectorpos, floor(random 50), random 360 ] call BIS_fnc_relPos ) findEmptyPosition [1, 200, "B_Heli_Light_01_F"];
		if ( count _sector_spawn_pos == 0 || surfaceIsWater _sector_spawn_pos ) then { _sector_spawn_pos = zeropos; };
	};

	if (_patrol_type == 1) then {
		_grp = createGroup [GRLIB_side_enemy, true];
		_squad = [] call F_getAdaptiveSquadComp;
		sleep 0.5;
		{
			_x createUnit [_sector_spawn_pos, _grp, "this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "PRIVATE"];
		} foreach _squad;
	};

	if (_patrol_type == 2) then {
		private [ "_vehicle_object" ];
		if (combat_readiness > 75 && floor(random 100) > 70) then {
			_vehicle_object = [ _sector_spawn_pos, selectRandom opfor_choppers ] call F_libSpawnVehicle;
		} else {
			_vehicle_object = [ _sector_spawn_pos, [] call F_getAdaptiveVehicle ] call F_libSpawnVehicle;
		};
		sleep 0.5;
		_grp = group ((crew _vehicle_object) select 0);
	};

	if (_patrol_type == 3) then {
		private [ "_vehicle_object" ];
		_opfor_spawn = [sectors_tower + sectors_military, {!( _x in (west_sectors + east_sectors) )}] call BIS_fnc_conditionalSelect;
		if ( count _opfor_spawn > 0) then {
			_grp = createGroup [GRLIB_side_enemy, true];
			_tower_spawn_pos = [ getMarkerPos (selectRandom _opfor_spawn), floor(random 50), random 360 ] call BIS_fnc_relPos;
			_vehicle_object = [ _tower_spawn_pos, selectRandom opfor_statics ] call F_libSpawnVehicle;
			_grp_veh = group _vehicle_object;
			[_vehicle_object] spawn protect_static;
			"O_spotter_F" createUnit [ getpos _vehicle_object, _grp, "this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "PRIVATE"];
			"O_spotter_F" createUnit [ getpos _vehicle_object, _grp, "this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "PRIVATE"];
 			(units _grp_veh) joinSilent _grp;
			{ _x setVariable ["OPFor_vehicle", _vehicle_object] } forEach units _grp;
		};
	};

	sleep 1;
	if (!isNil "_grp") then {
		[_grp, _patrol_type] spawn patrol_ai;

		_started_time = time;
		_patrol_continue = true;

		if ( local _grp ) then {
			_headless_client = [] call F_lessLoadedHC;
			if ( !isNull _headless_client ) then {
				_grp setGroupOwner ( owner _headless_client );
			};
		};

		while { _patrol_continue } do {
			sleep 60;
			if ( count (units _grp) == 0 ) then {
				_patrol_continue = false;
			} else {
				if ( time - _started_time > 900 ) then {
					_west_units = [getpos (leader _grp) , (GRLIB_sector_size * 2) , GRLIB_side_west] call F_getUnitsCount;
					_east_units = [getpos (leader _grp) , (GRLIB_sector_size * 2) , GRLIB_side_east] call F_getUnitsCount;
					if ( _west_units == 0 && _east_units == 0 ) then {
						_patrol_continue = false;
						{
							if ( vehicle _x != _x ) then {
								deleteVehicle (vehicle _x);
							};
							deleteVehicle _x;
						} foreach (units _grp);
						deleteGroup _grp;
					};
				};
			};
		};
	};
	if ( !([] call F_isBigtownActive) ) then {
		sleep (300.0 / GRLIB_difficulty_modifier);
	};

};