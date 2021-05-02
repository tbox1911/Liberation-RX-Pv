params [ "_sector" ];
private [ "_sectorpos", "_stopit", "_spawncivs", "_building_ai_max", "_infsquad", "_building_range", "_local_capture_size", "_iedcount","_combat_readiness_increase","_vehtospawn","_managed_units","_squad1", "_squad2", "_squad3", "_squad4", "_minimum_building_positions", "_popfactor", "_sector_despawn_tickets", "_opforcount" ];

waitUntil {sleep 1; !isNil "combat_readiness" };

_sectorpos = getmarkerpos _sector;
_stopit = false;
_spawncivs = false;
_building_ai_max = 0;
_infsquad = "militia";
_building_range = 200;
_local_capture_size = GRLIB_capture_size;
_iedcount = 0;
_vehtospawn = [];
_managed_units = [];
_squad1 = [];
_squad2 = [];
_squad3 = [];
_squad4 = [];
_minimum_building_positions = 5;
_sector_despawn_tickets = 12;

_popfactor = 1;
if ( GRLIB_unitcap < 1 ) then { _popfactor = GRLIB_unitcap; };

if ( isNil "active_sectors" ) then { active_sectors = [] };
if ( _sector in active_sectors ) exitWith {};
active_sectors pushback _sector; publicVariable "active_sectors";

diag_log format ["Spawn Defend Sector %1 at %2", _sector, time];
_opforcount = [] call F_opforCap;
//[ _sector, _opforcount ] call wait_to_spawn_sector;
sleep 5;

_west_units = [getmarkerpos _sector , [ _opforcount ] call F_getCorrectedSectorRange , GRLIB_side_west] call F_getUnitsCount;
_east_units = [getmarkerpos _sector , [ _opforcount ] call F_getCorrectedSectorRange , GRLIB_side_east] call F_getUnitsCount;

if ( (!(_sector in [west_sectors, east_sectors])) && ( _west_units > 0 || _east_units > 0) ) then {

	if ( _sector in sectors_bigtown ) then {
		_vehtospawn =
		[ ( [] call F_getAdaptiveVehicle ) ,
		(selectRandom militia_vehicles),
		(selectRandom militia_vehicles)];
		_infsquad = "militia";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if ( GRLIB_unitcap >= 1) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if ( GRLIB_unitcap >= 1.5) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (50 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		_spawncivs = true;

		_building_ai_max = round (15 * _popfactor) ;
		_building_range = 300;
		_local_capture_size = _local_capture_size * 1.4;
		_iedcount = (2 + (floor (random 4))) * GRLIB_difficulty_modifier;
		if ( _iedcount > 10 ) then { _iedcount = 10 };
	};

	if ( _sector in sectors_capture ) then {
		_vehtospawn = [];
		_infsquad = "militia";
		while { count _squad1 < ( 20 * _popfactor) } do { _squad1 pushback ( selectRandom militia_squad ) };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		_spawncivs = true;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 200;
		_iedcount = (floor (random 4)) * GRLIB_difficulty_modifier;
		if ( _iedcount > 7 ) then { _iedcount = 7 };
	};

	if ( _sector in sectors_military ) then {
		_infsquad = "csat";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if ( GRLIB_unitcap >= 1.5) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if ( GRLIB_unitcap >= 2) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		_vehtospawn = [( [] call F_getAdaptiveVehicle ),( [] call F_getAdaptiveVehicle )];
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		_spawncivs = false;
		_building_ai_max = round ((floor (8 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 110;
	};

	if ( _sector in sectors_factory ) then {
		_vehtospawn = [];
		_infsquad = "militia";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if ( GRLIB_unitcap >= 1.25) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if(floor(random 100) > 66) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		if(floor(random 100) > 33) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		_spawncivs = false;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 100;
		_iedcount = (floor (random 3)) * GRLIB_difficulty_modifier;
		if ( _iedcount > 5 ) then { _iedcount = 5 };
	};

	if ( _sector in sectors_tower ) then {
		_spawncivs = false;
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if ( GRLIB_unitcap >= 1.5) then {
			_squad2 = ([] call F_getAdaptiveSquadComp);
		};
		_building_ai_max = 0;
		if(floor(random 100) > 75) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		[markerPos _sector, 50] call createlandmines;
	};

	if ( _building_ai_max > 0 ) then {
		_building_ai_max = round ( _building_ai_max );
	};

	{
		_vehicle = [_sectorpos, _x] call F_libSpawnVehicle;
		[group ((crew _vehicle) select 0 ),_sectorpos] spawn add_defense_waypoints;
		_managed_units pushback _vehicle;
		{ _managed_units pushback _x; } foreach (crew _vehicle);
		sleep 0.25;
	} foreach _vehtospawn;

	if ( _building_ai_max > 0 ) then {
		_allbuildings = [ nearestObjects [_sectorpos, ["House"], _building_range ], { alive _x } ] call BIS_fnc_conditionalSelect;
		_buildingpositions = [];
		{
			_buildingpositions = _buildingpositions + ( [_x] call BIS_fnc_buildingPositions );
		} foreach _allbuildings;
		if ( count _buildingpositions > _minimum_building_positions ) then {
			_managed_units = _managed_units + ( [ _infsquad, _building_ai_max, _buildingpositions, _sectorpos, _sector ] call F_spawnBuildingSquad );
		};
	};

	_managed_units = _managed_units + ( [ _sectorpos ] call F_spawnMilitaryPostSquad );

	if ( count _squad1 > 0 ) then {
		_grp = [ _sector, _squad1 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad2 > 0 ) then {
		_grp = [ _sector, _squad2 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad3 > 0 ) then {
		_grp = [ _sector, _squad3 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad4 > 0 ) then {
		_grp = [ _sector, _squad4 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( _spawncivs && GRLIB_civilian_activity > 0) then {
		private _nbcivs = round ((4 + (floor (random 5))) * GRLIB_civilian_activity);
		if ( _sector in sectors_bigtown ) then { _nbcivs = _nbcivs + 10 };
		_managed_units = _managed_units + ([ _sector, _nbcivs ] call F_spawnCivilians);
	};

	[ _sector, _building_range, _iedcount ] spawn ied_manager;

	sleep 10;

	if ( ( _sector in sectors_factory ) || (_sector in sectors_capture ) || (_sector in sectors_bigtown ) || (_sector in sectors_military ) ) then {
		[ _sector ] remoteExec ["reinforcements_remote_call", 2];
	};

	while { !_stopit } do {
		private _winner_side = [_sectorpos, _local_capture_size] call F_sectorOwnership;
		if ( (_winner_side != GRLIB_side_enemy) && (GRLIB_endgame == 0) ) then {
			[ _sector, _winner_side ] spawn sector_liberated_remote_call;
			_stopit = true;
			{ [_x] spawn prisonner_ai; } foreach ( (getmarkerpos _sector) nearEntities [ ["Man"], _local_capture_size * 1.2 ] );
			sleep 60;

			active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";
			{ _x setVariable ["GRLIB_counter_TTL", 0] } foreach _managed_units;
		} else {
			_west_units = [_sectorpos , GRLIB_sector_size +300, GRLIB_side_west] call F_getUnitsCount;
			_east_units = [_sectorpos , GRLIB_sector_size +300, GRLIB_side_east] call F_getUnitsCount;
			if ( _west_units == 0 && _east_units == 0) then {
				_sector_despawn_tickets = _sector_despawn_tickets - 1;
			} else {
				_sector_despawn_tickets = 24;
			};

			if ( _sector_despawn_tickets <= 0 ) then {
				//{ deleteVehicle _x } foreach _managed_units;
				{
					if (_x isKindOf "Man") then {
						deleteVehicle _x;
					} else {
						_x setVariable ["GRLIB_counter_TTL", 0];
					};
				} foreach _managed_units;
				_stopit = true;
				active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";
			};
		};
		sleep 5;
	};
} else {
	sleep 40;
	active_sectors = active_sectors - [ _sector ]; publicVariable "active_sectors";
};
diag_log format ["End Defend Sector %1 at %2", _sector, time];