// Fetch LRX Server Parameters
GRLIB_difficulty_modifier = ["Difficulty",1] call bis_fnc_getParamValue;
GRLIB_time_factor = ["DayDuration",1] call bis_fnc_getParamValue;
GRLIB_resources_multiplier = ["ResourcesMultiplier",1] call bis_fnc_getParamValue;
GRLIB_fatigue = ["Fatigue",0] call bis_fnc_getParamValue;
GRLIB_revive = ["Revive",2] call bis_fnc_getParamValue;
GRLIB_tk_mode = ["TK_mode",0] call bis_fnc_getParamValue;
GRLIB_tk_count = ["TK_count",4] call bis_fnc_getParamValue;
GRLIB_introduction = ["Introduction",1] call bis_fnc_getParamValue;
GRLIB_deployment_cinematic = ["DeploymentCinematic",1] call bis_fnc_getParamValue;
GRLIB_unitcap = ["Unitcap",1] call bis_fnc_getParamValue;
GRLIB_civilian_activity = ["Civilians",1] call bis_fnc_getParamValue;
GRLIB_wildlife_manager = ["Wildlife",1] call bis_fnc_getParamValue;
GRLIB_Patrol_manager = ["Patrol",1] call bis_fnc_getParamValue;
GRLIB_sector_radius = ["SectorRadius",0] call bis_fnc_getParamValue;
GRLIB_admin_menu = ["AdminMenu",1] call bis_fnc_getParamValue;
GRLIB_param_wipe_savegame_1 = ["WipeSave1",0] call bis_fnc_getParamValue;
GRLIB_param_wipe_savegame_2 = ["WipeSave2",0] call bis_fnc_getParamValue;
GRLIB_permissions_param = ["Permissions",1] call bis_fnc_getParamValue;
GRLIB_halo_param = ["HaloJump",1] call bis_fnc_getParamValue;
GRLIB_cleanup_vehicles = ["CleanupVehicles",2] call bis_fnc_getParamValue;
GRLIB_csat_aggressivity = ["Aggressivity",1] call bis_fnc_getParamValue;
GRLIB_weather_param = ["Weather",4] call bis_fnc_getParamValue;
GRLIB_shorter_nights = ["ShorterNights",1] call bis_fnc_getParamValue;
GRLIB_ammo_bounties = [ "AmmoBounties",0] call bis_fnc_getParamValue;
GRLIB_civ_penalties = [ "CivPenalties",0] call bis_fnc_getParamValue;
GRLIB_remote_sensors = [ "DisableRemoteSensors",0] call bis_fnc_getParamValue;
GRLIB_city_defenders = [ "CityDefenders",1] call bis_fnc_getParamValue;
GRLIB_maximum_fobs = [ "MaximumFobs",5] call bis_fnc_getParamValue;
GRLIB_fob_type = [ "FobType",0] call bis_fnc_getParamValue;
GRLIB_opfor_english = [ "EnglishOpfor", 1] call bis_fnc_getParamValue;
GRLIB_squad_size = ["SquadSize",3] call bis_fnc_getParamValue;
GRLIB_max_squad_size = ["MaxSquadSize",7] call bis_fnc_getParamValue;
GRLIB_enable_arsenal = ["EnableArsenal",1] call bis_fnc_getParamValue;
GRLIB_limited_arsenal = ["LimitedArsenal",1] call bis_fnc_getParamValue;
GRLIB_permission_vehicles = ["EnableLock",1] call bis_fnc_getParamValue;
GRLIB_forced_loadout = ["ForcedLoadout",0] call bis_fnc_getParamValue;
GRLIB_fancy_info = ["FancyInfo",1] call bis_fnc_getParamValue;
GRLIB_overide_opfor = ["TextureOveride",0] call bis_fnc_getParamValue;
GRLIB_hide_opfor = ["HideOpfor",0] call bis_fnc_getParamValue;
GRLIB_thermic = ["Thermic",1] call bis_fnc_getParamValue;
GRLIB_mod_preset_west = ["ModPresetWest", 0] call bis_fnc_getParamValue;
GRLIB_mod_preset_east = ["ModPresetEast", 0] call bis_fnc_getParamValue;
GRLIB_mod_preset_indp = ["ModPresetIndp", 0] call bis_fnc_getParamValue;

// Define constant
[] call compileFinal preprocessFileLineNUmbers "gameplay_constants.sqf";

// Classename MOD source
[] call compileFinal preprocessFileLineNUmbers "scripts\mod_template\mod_init.sqf";
if (isNil "GRLIB_mod_west") then { GRLIB_mod_west = GRLIB_mod_list_west select GRLIB_mod_preset_west };
if (isNil "GRLIB_mod_east") then { GRLIB_mod_east = GRLIB_mod_list_east select GRLIB_mod_preset_east };
if (isNil "GRLIB_mod_indp") then { GRLIB_mod_indp = GRLIB_mod_list_indp select GRLIB_mod_preset_indp };

// Check wrong sides
abort_loading = false;
if (GRLIB_mod_west == GRLIB_mod_east || GRLIB_mod_west == GRLIB_mod_indp || GRLIB_mod_east == GRLIB_mod_indp ) then { abort_loading = true };
publicVariable "abort_loading";
if (abort_loading) exitWith {
	diag_log "*********************************************************************************";
	diag_log "FATAL! - Invalid Side selection !";
	diag_log "Loading Aborted to protect data integrity.";
	diag_log "Correct the Side selection.";
	diag_log "*********************************************************************************";
};

GRLIB_r1 = "&#108;&#105;&#98;&#101;&#114;&#97;&#116;&#105;&#111;&#110;";
GRLIB_r2 = "&#114;&#120;";
GRLIB_r3 = "&#76;&#82;&#88;&#32;&#73;&#110;&#102;&#111;";

//Detect Addons ACE ACRE OPTRE GM
GRLIB_ACE_enabled = isClass(configFile >> "cfgPatches" >> "ace_main"); // Returns true if ACE is enabled
GRLIB_ACRE_enabled = isClass(configFile >> "cfgPatches" >> "acre_main"); // Returns true if ACRE is enabled
GRLIB_OPTRE_enabled = isClass(configFile >> "cfgPatches" >> "OPTRE_Core"); // Returns true if OPTRE is enabled
GRLIB_GM_enabled = isClass(configFile >> "cfgPatches" >> "gm_Core"); // Returns true if GlobMob is enabled
GRLIB_CUPW_enabled = isClass(configFile >> "CfgPatches" >> "CUP_Weapons_AK"); // Returns true if CUP Weapons is enabled
GRLIB_EJW_enabled = isClass(configFile >> "CfgPatches" >> "Ej_u100"); // Returns true if EricJ Weapons is enabled 
GRLIB_Red_Edition = (missionName find "RX_Red" > 0);

if ( GRLIB_ACE_enabled ) then {	GRLIB_revive = 0; GRLIB_fatigue = 1; GRLIB_fancy_info = 0; GRLIB_limited_arsenal = 0 };  // Disable PAR/Fatigue/Fancy if ACE present
if ( GRLIB_OPTRE_enabled ) then { GRLIB_MOD_signature = "OPTRE_" };
if ( GRLIB_GM_enabled ) then { GRLIB_MOD_signature = "gm_" };

if ( GRLIB_fatigue == 1 ) then { GRLIB_fatigue = true } else { GRLIB_fatigue = false };
if ( GRLIB_introduction == 1 ) then { GRLIB_introduction = true } else { GRLIB_introduction = false };
if ( GRLIB_deployment_cinematic == 1 ) then { GRLIB_deployment_cinematic = true } else { GRLIB_deployment_cinematic = false };
if ( GRLIB_admin_menu == 1 ) then { GRLIB_admin_menu = true } else { GRLIB_admin_menu = false };
if ( GRLIB_hide_opfor == 1 ) then { GRLIB_hide_opfor = true } else { GRLIB_hide_opfor = false };
if ( GRLIB_enable_arsenal == 1 ) then { GRLIB_enable_arsenal = true } else { GRLIB_enable_arsenal = false };
if ( GRLIB_limited_arsenal == 1 ) then { GRLIB_limited_arsenal = true } else { GRLIB_limited_arsenal = false };
if ( GRLIB_permission_vehicles == 1 ) then { GRLIB_permission_vehicles = true } else { GRLIB_permission_vehicles = false };
if ( GRLIB_permissions_param == 1 ) then { GRLIB_permissions_param = true } else { GRLIB_permissions_param = false };
if ( GRLIB_shorter_nights == 1 ) then { GRLIB_shorter_nights = true } else { GRLIB_shorter_nights = false };
if ( GRLIB_ammo_bounties == 1 ) then { GRLIB_ammo_bounties = true } else { GRLIB_ammo_bounties = false };
if ( GRLIB_civ_penalties == 1 ) then { GRLIB_civ_penalties = true } else { GRLIB_civ_penalties = false };
if ( GRLIB_city_defenders == 1 ) then { GRLIB_city_defenders = true } else { GRLIB_city_defenders = false };
if ( GRLIB_thermic == 1 ) then { GRLIB_thermic = true } else { GRLIB_thermic = false };
if ( GRLIB_opfor_english == 1 ) then { GRLIB_opfor_english = true } else { GRLIB_opfor_english = false };


// Overide sector radius
if (GRLIB_sector_radius != 0) then { GRLIB_sector_size = GRLIB_sector_radius };

// Overide Textures
opfor_texture_overide = [];
if (GRLIB_overide_opfor > 0) then {
	switch (GRLIB_overide_opfor) do {
		case 1: {opfor_texture_overide = ["Urban","Digital"] };
		case 2: {opfor_texture_overide = ["Pink"] };
	};
};