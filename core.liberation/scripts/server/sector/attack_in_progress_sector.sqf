params [ "_sector" ];
private [ "_attacktime", "_ownership", "_grp", "_squad_type" ];

sleep 5;

_ownership = [ markerpos _sector ] call F_sectorOwnership;
if ( _ownership != GRLIB_side_enemy ) exitWith {};


[ _sector, 1 ] remoteExec ["remote_call_sector", 0];
_attacktime = GRLIB_vulnerability_timer;

while { _attacktime > 0 && ( _ownership == GRLIB_side_enemy ) } do {
	_ownership = [markerpos _sector] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	if ( _attacktime <= 1 && ( [markerpos _sector] call F_sectorOwnership == GRLIB_side_enemy ) ) then {
		blufor_sectors = blufor_sectors - [ _sector ];
		publicVariable "blufor_sectors";
		[ _sector, 2 ] remoteExec ["remote_call_sector", 0];
		reset_battlegroups_ai = true;
		trigger_server_save = true;
		[] call recalculate_caps;
		stats_sectors_lost = stats_sectors_lost + 1;
	} else {
		[ _sector, 3 ] remoteExec ["remote_call_sector", 0];
		{ [_x] spawn prisonner_ai; } foreach ( (getmarkerpos _sector) nearEntities [ ["Man"], GRLIB_capture_size * 0.8 ] );
	};
};

