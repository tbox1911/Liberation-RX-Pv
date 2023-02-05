diag_log "--- Server Init start ---";

// Init owner on map vehicles
{
	if (_x isKindOf "AllVehicles") then {
		_x removeAllMPEventHandlers "MPKilled";
		_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
			_x setVariable ["GRLIB_vehicle_owner", "public", true];
		};
	};
} foreach vehicles;

// Init owner on user placed objects 
{
	if (getObjectType _x >= 8 && !(_x iskindof "Man")) then {
		if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
			_x setVariable ["GRLIB_vehicle_owner", "server", true];
		};
	};
} forEach (allMissionObjects "");

// Cleanup
cleanup_player = compileFinal preprocessFileLineNumbers "scripts\server\game\cleanup_player.sqf";

// AI
add_civ_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_civ_waypoints.sqf";
add_defense_waypoints = compileFinal preprocessFileLineNumbers "scripts\server\ai\add_defense_waypoints.sqf";
battlegroup_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\battlegroup_ai.sqf";
building_defence_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\building_defence_ai.sqf";
prisonner_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_ai.sqf";
prisonner_captured = compileFinal preprocessFileLineNumbers "scripts\server\ai\prisonner_captured.sqf";
bomber_ai = compileFinal preprocessFileLineNumbers "scripts\server\ai\bomber_ai.sqf";
troup_transport = compileFinal preprocessFileLineNumbers "scripts\server\ai\troup_transport.sqf";

// Battlegroup
spawn_air = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_air.sqf";
spawn_battlegroup = compileFinal preprocessFileLineNumbers "scripts\server\battlegroup\spawn_battlegroup.sqf";

// Game
load_game_mp = compileFinal preprocessFileLineNumbers "scripts\server\game\load_game_mp.sqf";
save_game_mp  = compileFinal preprocessFileLineNumbers "scripts\server\game\save_game_mp.sqf";
load_context = compileFinal preprocessFileLineNumbers "scripts\server\game\load_context.sqf";
save_context = compileFinal preprocessFileLineNumbers "scripts\server\game\save_context.sqf";
check_victory_conditions = compileFinal preprocessFileLineNumbers "scripts\server\game\check_victory_conditions.sqf";
attach_object_direct = compileFinal preprocessFileLineNumbers "scripts\server\game\attach_object_direct.sqf";
load_object_direct = compileFinal preprocessFileLineNumbers "scripts\server\game\load_object_direct.sqf";
get_rank = compileFinal preprocessFileLineNumbers "scripts\server\game\get_rank.sqf";

// Patrol
reinforcements_manager = compileFinal preprocessFileLineNumbers "scripts\server\patrols\reinforcements_manager.sqf";
send_paratroopers = compileFinal preprocessFileLineNumbers "scripts\server\patrols\send_paratroopers.sqf";

// Resources
recalculate_caps = compileFinal preprocessFileLineNumbers "scripts\server\resources\recalculate_caps.sqf";

// Secondary objectives
fob_hunting = compileFinal preprocessFileLineNumbers "scripts\server\secondary\fob_hunting.sqf";
convoy_hijack = compileFinal preprocessFileLineNumbers "scripts\server\secondary\convoy_hijack.sqf";
search_and_rescue = compileFinal preprocessFileLineNumbers "scripts\server\secondary\search_and_rescue.sqf";

// Sector
attack_in_progress_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_fob.sqf";
attack_in_progress_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\attack_in_progress_sector.sqf";
destroy_fob = compileFinal preprocessFileLineNumbers "scripts\server\sector\destroy_fob.sqf";
ied_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\ied_manager.sqf";
static_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\static_manager.sqf";
patrol_manager = compileFinal preprocessFileLineNumbers "scripts\server\sector\patrol_manager.sqf";
manage_ammoboxes = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_ammoboxes.sqf";
manage_one_sector = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_one_sector.sqf";

// A3W
boxSetup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_boxSetup.sqf";
createlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createLandMines.sqf";
showlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_showLandMines.sqf";
clearlandmines = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_clearLandMines.sqf";

if (!([] call F_getValid)) exitWith {};

[] call load_game_mp;
if (abort_loading) exitWith {
	GRLIB_init_server = false;
	publicVariable "GRLIB_init_server";
	publicVariable "abort_loading";
	publicVariable "abort_loading_msg";
};

[] execVM "scripts\server\game\apply_saved_scores.sqf";
[] execVM "scripts\server\game\apply_default_permissions.sqf";
[] execVM "scripts\server\base\fobbox_manager_west.sqf";
[] execVM "scripts\server\base\fobbox_manager_east.sqf";
[] execVM "scripts\server\base\huron_manager_west.sqf";
[] execVM "scripts\server\base\huron_manager_east.sqf";
[] execVM "scripts\server\game\spawn_radio_towers.sqf";
[] execVM "scripts\server\game\hall_of_fame.sqf";
[] execVM "scripts\server\battlegroup\counter_battlegroup.sqf";
[] execVM "scripts\server\battlegroup\random_battlegroups.sqf";
[] execVM "scripts\server\battlegroup\readiness_increase.sqf";
[] execVM "scripts\server\resources\unit_cap.sqf";
[] execVM "scripts\server\resources\recalculate_resources.sqf";
[] execVM "scripts\server\resources\manage_resources.sqf";
[] execVM "scripts\server\patrols\civilian_patrols.sqf";
[] execVM "scripts\server\sector\manage_sectors.sqf";
[] execVM "scripts\server\sector\lose_sectors.sqf";
[] execVM "scripts\server\game\manage_score.sqf";
[] execVM "scripts\server\game\manage_time.sqf";
[] execVM "scripts\server\game\manage_weather.sqf";
[] execVM "scripts\server\game\manage_static.sqf";
[] execVM "scripts\server\game\init_marker.sqf";
[] execVM "scripts\server\secondary\autostart.sqf";
[] execVM "scripts\server\game\synchronise_vars_west.sqf";
[] execVM "scripts\server\game\synchronise_vars_east.sqf";
[] execVM "scripts\server\game\playtime.sqf";
[] execVM "scripts\server\game\clean.sqf";
[] execVM "scripts\server\game\periodic_save.sqf";
[] execVM "scripts\server\a3w\init_missions.sqf";
[] execVM "scripts\server\ar\fn_advancedRappellingInit.sqf";

// Offloading
[] execVM "scripts\server\offloading\offload_calculation.sqf";
[] execVM "scripts\server\offloading\offload_manager.sqf";
[] execVM "scripts\server\offloading\show_fps.sqf";

global_locked_group = [];
publicVariable "global_locked_group";

addMissionEventHandler ["MPEnded", { diag_log "--- LRX Mission End!" }];
addMissionEventHandler ['HandleDisconnect', {
	_this call cleanup_player;
	if (count (AllPlayers - (entities "HeadlessClient_F")) == 0) then {
		[] call save_game_mp;
		{ deleteVehicle _x } forEach (allUnits);
	};
	false;
}];

// AI Skill
[ 
 true, 
 [ 
  [GRLIB_side_west, 0.5, 0.3, 0.7, 0.6], 
  [GRLIB_side_east, 0.5, 0.3, 0.7, 0.6], 
  [GRLIB_side_enemy, 0.5, 0.3, 0.7, 0.6]
 ]
] call BIS_fnc_EXP_camp_dynamicAISkill;

sleep 3;
GRLIB_init_server = true;
publicVariable "GRLIB_init_server";
diag_log "--- Server Init stop ---";
