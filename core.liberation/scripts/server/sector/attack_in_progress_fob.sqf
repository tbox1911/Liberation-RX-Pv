params [ "_thispos" ];
private [ "_attacktime", "_ownership", "_grp" ];

sleep 5;

_ownership = [ _thispos ] call F_sectorOwnership;

[ _thispos , 1 ] remoteExec ["remote_call_fob", 0];

_attacktime = GRLIB_vulnerability_timer;

while { _attacktime > 0 && ( _ownership == GRLIB_side_enemy ) } do {
	_ownership = [ _thispos ] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	if (_attacktime mod 60 == 0) then {
		[ _thispos , 4 ] remoteExec ["remote_call_fob", 0];
	};
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	if ( _attacktime <= 1 && ( [ _thispos ] call F_sectorOwnership == GRLIB_side_enemy ) ) then {
		[ _thispos , 2 ] remoteExec ["remote_call_fob", 0];
		sleep 3;
		[_thispos, 250] remoteExec ["remote_call_penalty", 0];
		sleep 3;
		GRLIB_fobs_west = GRLIB_fobs_west - [_thispos];
		publicVariable "GRLIB_fobs_west";
		reset_battlegroups_ai = true;
		[_thispos] call destroy_fob;
		trigger_server_save = true;
		[] call recalculate_caps;
		stats_fobs_lost = stats_fobs_lost + 1;
	} else {
		[ _thispos , 3 ] remoteExec ["remote_call_fob", 0];
		{ [_x] spawn prisonner_ai; } foreach ( _thispos nearEntities [ ["Man"], GRLIB_capture_size * 0.8 ] );
	};
};
