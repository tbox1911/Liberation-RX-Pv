params [ "_sector", "_side" ];
if (_sector in active_sectors) exitWith {};
active_sectors pushback _sector;
sleep 1;

private _sector_oldside = GRLIB_side_enemy;
if (_sector in west_sectors) then { _sector_oldside = GRLIB_side_west};
if (_sector in east_sectors) then { _sector_oldside = GRLIB_side_east};

[ _sector, 1, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
[ _sector, 1, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];

private _attacktime = GRLIB_vulnerability_timer;
private _ownership = [ markerpos _sector ] call F_sectorOwnership;

while { _attacktime > 0 && _ownership == _side } do {
	_ownership = [markerpos _sector] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	private _sector_owner =  [markerpos _sector] call F_sectorOwnership;
	if ( _attacktime <= 1 && _sector_owner == _side ) then {

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
		trigger_server_save = true;
		[] call recalculate_caps;
		stats_sectors_lost = stats_sectors_lost + 1;
	} else {
		[ _sector, 3, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
		[ _sector, 3, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
		{ [_x] spawn prisonner_ai; } foreach ( (getmarkerpos _sector) nearEntities [ ["Man"], GRLIB_capture_size * 0.8 ] );
	};
};

sleep 3;
active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";