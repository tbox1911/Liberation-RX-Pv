params [ "_thispos", "_side" ];
if (_thispos in active_fobs) exitWith {};
active_fobs pushback _thispos;
sleep 1;
diag_log format ["Spawn Attack FOB %1 by side %2 at %3", ([_thispos] call F_getFobName), _side, time];

private _fobside = [_thispos] call F_getFobSide;

[ _thispos, 1, _fobside ] remoteExec ["remote_call_fob", 0];
[ _thispos, 5, _side ] remoteExec ["remote_call_fob", 0];

private _attacktime = GRLIB_vulnerability_timer;
private _ownership = [ _thispos ] call F_sectorOwnership;

while { _attacktime > 0 && ( _ownership == _side ) } do {
	_ownership = [ _thispos ] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	if (_attacktime mod 60 == 0) then {
		[ _thispos, 4, _fobside ] remoteExec ["remote_call_fob", 0];
	};
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	private _sector_owner =  [_thispos] call F_sectorOwnership;
	if ( _attacktime <= 1 && _sector_owner == _side ) then {

		[_thispos, _side] call destroy_fob;

		if (_fobside == GRLIB_side_west) then {
			GRLIB_fobs_west = GRLIB_fobs_west - [_thispos];publicVariable "GRLIB_fobs_west";
			[ _thispos, 2, GRLIB_side_west ] remoteExec ["remote_call_fob", 0];
		};

		if (_fobside == GRLIB_side_east) then {
			GRLIB_fobs_east = GRLIB_fobs_east - [_thispos];publicVariable "GRLIB_fobs_east";
			[ _thispos, 2, GRLIB_side_east ] remoteExec ["remote_call_fob", 0];
		};

		if (_sector_owner == GRLIB_side_west) then {
			[_thispos, 6, GRLIB_side_west] remoteExec ["remote_call_fob", 0];
		};

		if (_sector_owner == GRLIB_side_east) then {
			[_thispos, 6, GRLIB_side_east] remoteExec ["remote_call_fob", 0];
		};

		reset_battlegroups_ai = true;
		trigger_server_save = true;
		[] call recalculate_caps;
		stats_fobs_lost = stats_fobs_lost + 1;
	} else {
		[ _thispos, 3, GRLIB_side_west ] remoteExec ["remote_call_fob", 0];
		[ _thispos, 3, GRLIB_side_east ] remoteExec ["remote_call_fob", 0];
		//{ [_x] spawn prisonner_ai; } foreach ( _thispos nearEntities [ ["Man"], GRLIB_capture_size * 0.8 ] );
	};
};

sleep 600;
diag_log format ["End Attack FOB %1 by side %2 at %3", ([_thispos] call F_getFobName), _side, time];
active_fobs = active_fobs - [ _thispos ];