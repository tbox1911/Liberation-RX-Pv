sleep 5;

_maxSector = count (sectors_allSectors);
_bluSector = count (west_sectors);
_opfSector = count (east_sectors);
_indSector = (_maxsector - _bluSector - _opfSector);

//_maxSector = _maxSector * 0.80; // 80% sector captured
if (_indSector == 0 && (_bluSector >= _maxSector || _opfSector  >= _maxSector)) then {
	GRLIB_endgame = 1;
	publicVariable "GRLIB_endgame";
	{ _x allowDamage false; (vehicle _x) allowDamage false; } foreach allPlayers;

	publicstats = [];
	publicstats pushback stats_opfor_soldiers_killed;
	publicstats pushback stats_opfor_killed_by_players;
	publicstats pushback stats_blufor_soldiers_killed;
	publicstats pushback stats_player_deaths;
	publicstats pushback stats_opfor_vehicles_killed;
	publicstats pushback stats_opfor_vehicles_killed_by_players;
	publicstats pushback stats_blufor_vehicles_killed;
	publicstats pushback stats_blufor_soldiers_recruited;
	publicstats pushback stats_blufor_vehicles_built;
	publicstats pushback stats_civilians_killed;
	publicstats pushback stats_civilians_killed_by_players;
	publicstats pushback stats_sectors_liberated;
	publicstats pushback stats_playtime;
	publicstats pushback stats_spartan_respawns;
	publicstats pushback stats_secondary_objectives;
	publicstats pushback stats_hostile_battlegroups;
	publicstats pushback stats_ieds_detonated;
	publicstats pushback stats_saves_performed;
	publicstats pushback stats_saves_loaded;
	publicstats pushback stats_reinforcements_called;
	publicstats pushback stats_prisonners_captured;
	publicstats pushback stats_blufor_teamkills;
	publicstats pushback stats_vehicles_recycled;
	publicstats pushback stats_ammo_spent;
	publicstats pushback stats_sectors_lost;
	publicstats pushback stats_fobs_built;
	publicstats pushback stats_fobs_lost;
	publicstats pushback (round stats_readiness_earned);

	[publicstats] remoteExec ["remote_call_endgame", allPlayers];

	sleep 20;

	{ if ( !(isPlayer _x) && _x distance lhd_west > GRLIB_sector_size && _x distance lhd_east > GRLIB_sector_size ) then { deleteVehicle _x } } foreach allUnits;

};