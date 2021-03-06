params [ "_sector", "_side" ];
if (_sector in active_sectors) exitWith {};
active_sectors pushback _sector;
sleep 1;
diag_log format ["Spawn Attack Sector %1 by side %2 at %3", _sector, _side, time];

private _sector_oldside = GRLIB_side_enemy;
if (_sector in west_sectors) then { _sector_oldside = GRLIB_side_west};
if (_sector in east_sectors) then { _sector_oldside = GRLIB_side_east};

[ _sector, 1, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
[ _sector, 1, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];

private _grp = grpNull;
if ( GRLIB_city_defenders ) then {
	private _squad_type = [];

	if (_sector_oldside == GRLIB_side_west) then {
		_squad_type = blufor_squad_inf_light;
		if ( _sector in (sectors_military + sectors_bigtown)) then { _squad_type = blufor_squad_inf };
	};
	
	if (_sector_oldside == GRLIB_side_east) then {
		_squad_type = opfor_squad_inf_light;
		if ( _sector in (sectors_military + sectors_bigtown)) then { _squad_type = opfor_squad_inf };
	};

	_grp = createGroup [_sector_oldside, true];

	for "_i" from 1 to 8 do {	
		_unit = _grp createUnit [(selectRandom _squad_type), markerpos _sector, [], 80, "NONE"];
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_unit setSkill 0.65;
		_unit setSkill ["courage", 1];
		_unit allowFleeing 0;
 	} foreach _squad_type;

	_grp setCombatMode "GREEN";
	_grp setBehaviour "COMBAT";
	sleep 60;
};

private _attacktime = GRLIB_vulnerability_timer;
private _enemycount = [ getmarkerpos _sector , GRLIB_capture_size , _side] call F_getUnitsCount;
private _ownership = [markerpos _sector] call F_sectorOwnership;

while { _attacktime > 0 && (_ownership == _side || _enemycount >= 1) } do {
	_ownership = [markerpos _sector] call F_sectorOwnership;
	_enemycount = [ getmarkerpos _sector , GRLIB_capture_size , _side] call F_getUnitsCount;
	_attacktime = _attacktime - 1;
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	private _sector_owner = [markerpos _sector] call F_sectorOwnership;
	if ( _sector_owner != _sector_oldside ) then {
		
		diag_log format ["End Attack Sector %1 captured by %2 to %3", _sector, _sector_owner, _sector_oldside];
		if (_sector_owner == GRLIB_side_west) then {
			west_sectors = west_sectors + [ _sector ];publicVariable "west_sectors";
			[ _sector, 0, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
		};

		if (_sector_owner == GRLIB_side_east) then {
			east_sectors = east_sectors + [ _sector ];publicVariable "east_sectors";
			[ _sector, 0, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
		};

		if (_sector_oldside == GRLIB_side_west) then {
			west_sectors = west_sectors - [ _sector ];publicVariable "west_sectors";
			[ _sector, 2, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
		};

		if (_sector_oldside == GRLIB_side_east) then {
			east_sectors = east_sectors - [ _sector ];publicVariable "east_sectors";
			[ _sector, 2, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
		};

		reset_battlegroups_ai = true;
		[] call recalculate_caps;
		[] spawn check_victory_conditions;
		sleep 1;
		trigger_server_save = true;
		stats_sectors_lost = stats_sectors_lost + 1;
	} else {
		[ _sector, 3, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
		[ _sector, 3, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
		//{ [_x] spawn prisonner_ai; } foreach ( (getmarkerpos _sector) nearEntities [ ["Man"], GRLIB_capture_size * 0.8 ] );
	};
};

diag_log format ["End Attack Sector %1 by side %2 at %3", _sector, _side, time];
sleep 60;
if ( GRLIB_city_defenders ) then {
	{ if ( alive _x ) then { deleteVehicle _x } } foreach units _grp;
};

sleep 300;
active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";