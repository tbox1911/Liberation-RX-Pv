waitUntil { !isNil "GRLIB_fobs_west" };
waitUntil { !isNil "GRLIB_fobs_east" };
waitUntil { !isNil "west_sectors" };
waitUntil { !isNil "east_sectors" };
active_fobs = [];
sleep 5;

while { GRLIB_endgame == 0 } do {

	{
		_ownership = [ markerpos _x ] call F_sectorOwnership;
		if ( _ownership in [GRLIB_side_enemy, GRLIB_side_east]) then {
			[ _x, _ownership ] spawn attack_in_progress_sector;
		};
		sleep 0.25;
	} foreach west_sectors - active_sectors;

	{
		_ownership = [ markerpos _x ] call F_sectorOwnership;
		if ( _ownership in [GRLIB_side_enemy, GRLIB_side_west]) then {
			[ _x, _ownership ] spawn attack_in_progress_sector;
		};
		sleep 0.25;
	} foreach east_sectors - active_sectors;

	{
		_ownership = [ _x ] call F_sectorOwnership;
		if ( _ownership in [GRLIB_side_enemy, GRLIB_side_east]) then {
			[ _x, _ownership ] spawn attack_in_progress_fob;
		};
		sleep 0.25;
	} foreach GRLIB_fobs_west - active_fobs;

	{
		_ownership = [ _x ] call F_sectorOwnership;
		if ( _ownership in [GRLIB_side_enemy, GRLIB_side_west]) then {
			[ _x, _ownership ] spawn attack_in_progress_fob;
		};
		sleep 0.25;
	} foreach GRLIB_fobs_east - active_fobs;

	sleep 5;
};
