params [ "_sector", "_side" ];
private [ "_attacktime", "_ownership", "_grp", "_squad_type" ];
sleep 10;

_ownership = [ markerpos _sector ] call F_sectorOwnership;
if ( _ownership != _side ) exitWith {};

active_sectors pushback _sector;

[ _sector, 1, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
[ _sector, 1, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];

_attacktime = GRLIB_vulnerability_timer;

while { _attacktime > 0 && _ownership == _side } do {
	_ownership = [markerpos _sector] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	private _sector_owner =  [markerpos _sector] call F_sectorOwnership;
	if ( _attacktime <= 1 && _sector_owner == _side ) then {

		if (_sector_owner == GRLIB_side_west) then {
			east_sectors = east_sectors - [ _sector ];publicVariable "east_sectors";
			west_sectors = west_sectors + [ _sector ];publicVariable "west_sectors";
			[ _sector, 0, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
			[ _sector, 2, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
		};
		if (_sector_owner == GRLIB_side_east) then {
			west_sectors = west_sectors - [ _sector ];publicVariable "west_sectors";
			east_sectors = east_sectors + [ _sector ];publicVariable "east_sectors";
			[ _sector, 0, GRLIB_side_east ] remoteExec ["remote_call_sector", 0];
			[ _sector, 2, GRLIB_side_west ] remoteExec ["remote_call_sector", 0];
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