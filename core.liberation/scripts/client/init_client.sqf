diag_log "--- Client Init start ---";
titleText ["Loading...","BLACK FADED", 1000];

R3F_LOG_joueur_deplace_objet = objNull;
GRLIB_player_spawned = false;
GRLIB_side_friendly = side player;

GRLIB_respawn_marker = format ["respawn_%1", GRLIB_side_friendly];
if (GRLIB_side_friendly == GRLIB_side_west) then {
	my_lhd = lhd_west;
	GRLIB_Arsenal = LARsBox_west;
	GRLIB_color_friendly = GRLIB_color_west;
	huron_typename = huron_typename_west;
	FOB_typename = FOB_typename_west;
	FOB_box_typename = FOB_box_typename_west;
	FOB_truck_typename = FOB_truck_typename_west;
	Respawn_truck_typename = Respawn_truck_typename_west;
	ammo_truck_typename = ammo_truck_typename_west;
	fuel_truck_typename = fuel_truck_typename_west;
	repair_truck_typename = repair_truck_typename_west;
	repair_sling_typename = repair_sling_typename_west;
	fuel_sling_typename = fuel_sling_typename_west;
	ammo_sling_typename = ammo_sling_typename_west;
	medic_sling_typename = medic_sling_typename_west;
	commander_classname = commander_classname_west;
	crewman_classname = crewman_classname_west;
	pilot_classname = pilot_classname_west;
	infantry_units = [ infantry_units_west ] call F_filterMods;
	light_vehicles = [ light_vehicles_west ] call F_filterMods;
	heavy_vehicles = [ heavy_vehicles_west ] call F_filterMods;
	air_vehicles = [ air_vehicles_west ] call F_filterMods;
	support_vehicles = [ support_vehicles_west ] call F_filterMods;
	air_attack = air_attack_west;
	static_vehicles = [ static_vehicles_west ] call F_filterMods;
	buildings = [ buildings_west ] call F_filterMods;
	uavs = uavs_west;
	squads = squads_west;
	deleteMarkerLocal "base_chimera_east";
	deleteMarkerLocal "huronmarker_east";
} else {
	my_lhd = lhd_east;
	GRLIB_Arsenal = LARsBox_east;
	GRLIB_color_friendly = GRLIB_color_east;
	huron_typename = huron_typename_east;
	FOB_typename = FOB_typename_east;
	FOB_box_typename = FOB_box_typename_east;
	FOB_truck_typename = FOB_truck_typename_east;
	Respawn_truck_typename = Respawn_truck_typename_east;
	ammo_truck_typename = ammo_truck_typename_east;
	fuel_truck_typename = fuel_truck_typename_east;
	repair_truck_typename = repair_truck_typename_east;
	repair_sling_typename = repair_sling_typename_east;
	fuel_sling_typename = fuel_sling_typename_east;
	ammo_sling_typename = ammo_sling_typename_east;
	medic_sling_typename = medic_sling_typename_east;
	commander_classname = commander_classname_east;
	crewman_classname = crewman_classname_east;
	pilot_classname = pilot_classname_east;
	infantry_units = [ infantry_units_east ] call F_filterMods;
	light_vehicles = [ light_vehicles_east ] call F_filterMods;
	heavy_vehicles = [ heavy_vehicles_east ] call F_filterMods;
	air_vehicles = [ air_vehicles_east ] call F_filterMods;
	support_vehicles = [ support_vehicles_east ] call F_filterMods;
	air_attack = air_attack_east;
	static_vehicles = [ static_vehicles_east ] call F_filterMods;
	buildings = [ buildings_east ] call F_filterMods;
	uavs = uavs_east;
	squads = squads_east;
	deleteMarkerLocal "base_chimera_west";
	deleteMarkerLocal "huronmarker_west";
	deleteMarkerLocal "marker_332";
	deleteMarkerLocal "marker_334";
};
build_lists = [[],infantry_units,light_vehicles,heavy_vehicles,air_vehicles,static_vehicles,buildings,support_vehicles,squads];

// *** FNC ***
respawn_lhd = compileFinal preprocessFileLineNumbers "scripts\client\spawn\respawn_lhd.sqf";
spawn_camera = compileFinal preprocessFileLineNumbers "scripts\client\spawn\spawn_camera.sqf";
cinematic_camera = compileFinal preprocessFileLineNumbers "scripts\client\ui\cinematic_camera.sqf";
write_credit_line = compileFinal preprocessFileLineNumbers "scripts\client\ui\write_credit_line.sqf";
do_load_box = compileFinal preprocessFileLineNumbers "scripts\client\ammoboxes\do_load_box.sqf";
set_rank = compileFinal preprocessFileLineNumbers "scripts\client\misc\set_rank.sqf";
vehicle_permissions = compileFinal preprocessFileLineNumbers "scripts\client\misc\vehicle_permissions.sqf";
vehicle_defense = compileFinal preprocessFileLineNumbers "scripts\client\misc\vehicle_defense.sqf";
fetch_permission = compileFinal preprocessFileLineNumbers "scripts\client\misc\fetch_permission.sqf";
is_menuok = compileFinal preprocessFileLineNumbers "scripts\client\misc\is_menuok.sqf";
is_neartransport = compileFinal preprocessFileLineNumbers "scripts\client\misc\is_neartransport.sqf";
player_EVH = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_EventHandler.sqf";
paraDrop = compileFinal preprocessFileLineNumbers "scripts\client\spawn\paraDrop.sqf";
get_lrx_name = compileFinal preprocessFileLineNumbers "scripts\client\misc\get_lrx_name.sqf";
get_myFobs = compileFinal preprocessFileLineNumbers "scripts\client\misc\get_myfobs.sqf";
get_mySectors = compileFinal preprocessFileLineNumbers "scripts\client\misc\get_mysectors.sqf";
F_getMobileRespawns = compileFinal preprocessFileLineNumbers "scripts\shared\functions\F_getMobileRespawns.sqf";
F_spartanScan = compileFinal preprocessFileLineNumbers "scripts\shared\functions\F_spartanScan.sqf";
F_getLocationName = compileFinal preprocessFileLineNumbers "scripts\shared\functions\F_getLocationName.sqf";
F_getFobName = compileFinal preprocessFileLineNumbers "scripts\shared\functions\F_getFobName.sqf";
F_getNearestFobEnemy = compileFinal preprocessFileLineNumbers "scripts\shared\functions\F_getNearestFobEnemy.sqf";
F_getForceRatio = compileFinal preprocessFileLineNumbers "scripts\shared\functions\F_getForceRatio.sqf";

// *** Init ***

if (isMultiplayer) then {
	PAR_Grp_ID = getPlayerUID player;
} else {
	PAR_Grp_ID = str floor(random 4096);
};
((units player) - [player]) joinSilent grpNull;
my_group = group player;
[my_group, "add"] remoteExec ["addel_group_remote_call", 2];

[] execVM "scripts\client\misc\init_markers.sqf";
if (!([] call F_getValid)) exitWith {endMission "LOSER"};

if ( typeOf player == "VirtualSpectator_F" ) exitWith {
	[] execVM "scripts\client\markers\empty_vehicles_marker.sqf";
	[] execVM "scripts\client\markers\fob_markers.sqf";
	[] execVM "scripts\client\markers\hostile_groups.sqf";
	[] execVM "scripts\client\markers\huron_marker.sqf";
	[] execVM "scripts\client\markers\sector_manager.sqf";
	[] execVM "scripts\client\markers\spot_timer.sqf";
	[] execVM "scripts\client\misc\synchronise_vars.sqf";
	[] execVM "scripts\client\ui\ui_manager.sqf";
};

[] execVM "scripts\client\ui\intro.sqf";
[] execVM "scripts\client\ammoboxes\ammobox_action_manager.sqf";
[] execVM "scripts\client\markers\sector_manager.sqf";
[] execVM "scripts\client\misc\sides_stats_manager.sqf";
[] execVM "scripts\client\build\build_overlay.sqf";
[] execVM "scripts\client\build\do_build.sqf";
[] execVM "scripts\client\markers\empty_vehicles_marker.sqf";
[] execVM "scripts\client\markers\fob_markers.sqf";
[] execVM "scripts\client\markers\a3w_mission_marker.sqf";
[] execVM "scripts\client\markers\hostile_groups.sqf";
[] execVM "scripts\client\markers\huron_marker.sqf";
[] execVM "scripts\client\markers\spot_timer.sqf";
[] execVM "scripts\client\misc\broadcast_squad_colors.sqf";
[] execVM "scripts\client\misc\disable_remote_sensors.sqf";
//[] execVM "scripts\client\misc\offload_diag.sqf";
[] execVM "scripts\client\misc\permissions_warning.sqf";
[] execVM "scripts\client\misc\secondary_jip.sqf";
[] execVM "scripts\client\misc\stop_renegade.sqf";
[] execVM "scripts\client\misc\synchronise_vars.sqf";
[] execVM "scripts\client\misc\manage_weather.sqf";
[] execVM "scripts\client\misc\no_thermic.sqf";
[] execVM "scripts\client\actions\action_manager.sqf";
[] execVM "scripts\client\actions\action_manager_veh.sqf";
[] execVM "scripts\client\actions\recycle_manager.sqf";
[] execVM "scripts\client\actions\intel_manager.sqf";
[] execVM "scripts\client\actions\dog_manager.sqf";
[] execVM "scripts\client\actions\man_manager.sqf";
[] execVM "scripts\client\actions\squad_manager.sqf";
[] execVM "scripts\client\ui\ui_manager.sqf";

if (GRLIB_enable_arsenal) then {
	[] execVM "addons\LARs\liberationArsenal.sqf";
};

if (!GRLIB_ACE_enabled) then {
	[] execVM "addons\PAR\PAR_AI_Revive.sqf";
	[] execVM "addons\MGR\MagRepack_init.sqf";
	[] execVM "addons\NRE\NRE_init.sqf";
	[] execVM "addons\KEY\shortcut_init.sqf";
	[] execVM "scripts\client\misc\support_manager.sqf";
};
[] execVM "addons\VIRT\virtual_garage_init.sqf";
[] execVM "addons\TAXI\taxi_init.sqf";
[] execVM "addons\TARU\taru_init.sqf";

// Init Tips Tables from XML
GREUH_TipsText = [];
{
	if (_x select [0, 1] != "t" && _x != "br") then {
    	GREUH_TipsText pushback (_x select [7]);
	};
} forEach ((localize "STR_TUTO_TEXT12") splitString "></");

{
	[_x] call BIS_fnc_drawCuratorLocations;
} foreach allCurators;

// Sign Add
addMissionEventHandler["draw3D",{
	private _pos = ASLToAGL getPosASL chimera_sign;
	if (player distance2D _pos <= 30) then {
		drawIcon3D ["", [1,1,1,1], _pos vectorAdd [0, 0, 3], 0, 0, 0, "- READ ME -", 2, 0.05, "TahomaB"];
	};

	private _near_grave = nearestObjects [player, GRLIB_player_grave , 2];
	if (count (_near_grave) != 0) then {
		private _grave = _near_grave select 0;
		private _grave_pos = ASLToAGL getPosASL _grave;
		drawIcon3D [getMissionPath "res\skull.paa", [1,1,1,1], _grave_pos vectorAdd [0, 0, 1], 2, 2, 0, (_grave getVariable ["GRLIB_grave_message", ""]), 2, 0.05, "RobotoCondensed", "center"];
	};
}];
chimera_sign addAction ["<t color='#FFFFFF'>-= READ  ME =-</t>",{createDialog "liberation_notice"},"",999,true,true,"","[] call is_menuok",5];
chimera_sign addAction ["<t color='#FFFFFF'>-=   TIPS   =-</t>",{createDialog "liberation_tips"},"",998,true,true,"","[] call is_menuok",5];

waitUntil { time > 2 };
initAmbientLife;
enableEnvironment [true, true];
setTerrainGrid 12.5;  //Very High = 6.25, Ultra = 3.125

diag_log "--- Client Init stop ---";