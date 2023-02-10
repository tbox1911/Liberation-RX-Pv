// *** GLOBAL DEFINITIOON ***

markers_reset = [99999,99999,0];
zeropos = [0,0,0];

// All Object classname used in RX must be declared here

[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";

// *** DEFAULT ***
[] call compileFinal preprocessFileLineNUmbers format ["scripts\shared\default_classnames.sqf"];

// *** DEFENSE ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_east.sqf", GRLIB_mod_indp];

// *** BLUE ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_west.sqf", GRLIB_mod_west];
[infantry_units, GRLIB_mod_west] call F_calcUnitsCost;

// Remap list for side
huron_typename_west = huron_typename;
FOB_typename_west = FOB_typename;
FOB_box_typename_west = FOB_box_typename;
FOB_truck_typename_west = FOB_truck_typename;
Respawn_truck_typename_west = Respawn_truck_typename;
ammo_truck_typename_west = ammo_truck_typename;
fuel_truck_typename_west = fuel_truck_typename;
repair_truck_typename_west = repair_truck_typename;
repair_sling_typename_west = repair_sling_typename;
fuel_sling_typename_west = fuel_sling_typename;
ammo_sling_typename_west = ammo_sling_typename;
medic_sling_typename_west = medic_sling_typename;
commander_classname_west = commander_classname;
pilot_classname_west =  pilot_classname;
crewman_classname_west = crewman_classname;
infantry_units_west = infantry_units;
light_vehicles_west = light_vehicles;
heavy_vehicles_west = heavy_vehicles;
air_vehicles_west = air_vehicles;
air_attack_west = blufor_air;
static_vehicles_west = static_vehicles;
buildings_west = buildings_default + buildings;
support_vehicles_west = default_support_vehicles + support_vehicles;
squad_inf_west = blufor_squad_inf;
squad_inf_light_west = blufor_squad_inf_light;
squads_west = squads;
uavs_west = uavs;

// remap list common (should be sided ?)
static_vehicles_AI append static_vehicles_AI_west;
ai_resupply_sources append ai_resupply_sources_west;
ai_healing_sources append ai_healing_sources_west;
vehicle_rearm_sources append vehicle_rearm_sources_west;
vehicle_repair_sources append vehicle_repair_sources_west;
vehicle_big_units append vehicle_big_units_west;
GRLIB_vehicle_whitelist append GRLIB_vehicle_whitelist_west;
GRLIB_vehicle_blacklist append GRLIB_vehicle_blacklist_west;
{
	private _veh = _x select 0;
	if (!(_veh in uavs)) then { list_static_weapons pushback _veh };
} foreach static_vehicles;

// GRLIB_AirDrop_1 per side
//(maybe cleanup vars ?)

// *** RED ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_west.sqf", GRLIB_mod_east];
[infantry_units, GRLIB_mod_east] call F_calcUnitsCost;

// Remap list for side
huron_typename_east = huron_typename;
FOB_typename_east = FOB_typename;
FOB_box_typename_east = FOB_box_typename;
FOB_truck_typename_east = FOB_truck_typename;
Respawn_truck_typename_east = Respawn_truck_typename;
ammo_truck_typename_east = ammo_truck_typename;
fuel_truck_typename_east = fuel_truck_typename;
repair_truck_typename_east = repair_truck_typename;
repair_sling_typename_east = repair_sling_typename;
fuel_sling_typename_east = fuel_sling_typename;
ammo_sling_typename_east = ammo_sling_typename;
medic_sling_typename_east = medic_sling_typename;
commander_classname_east = commander_classname;
pilot_classname_east =  pilot_classname;
crewman_classname_east = crewman_classname;
infantry_units_east = infantry_units;
light_vehicles_east = light_vehicles;
heavy_vehicles_east = heavy_vehicles;
air_vehicles_east = air_vehicles;
air_attack_east = blufor_air;
static_vehicles_east = static_vehicles;
buildings_east = buildings_default + buildings;
support_vehicles_east = default_support_vehicles + support_vehicles;
squad_inf_east = blufor_squad_inf;
squad_inf_light_east = blufor_squad_inf_light;
squads_east = squads;
uavs_east = uavs;

// remap list common
static_vehicles_AI append static_vehicles_AI_west;
ai_resupply_sources append ai_resupply_sources_west;
ai_healing_sources append ai_healing_sources_west;
vehicle_rearm_sources append vehicle_rearm_sources_west;
vehicle_repair_sources append vehicle_repair_sources_west;
vehicle_big_units append vehicle_big_units_west;
GRLIB_vehicle_whitelist append GRLIB_vehicle_whitelist_west;
GRLIB_vehicle_blacklist append GRLIB_vehicle_blacklist_west;
{
	private _veh = _x select 0;
	if (!(_veh in uavs)) then { list_static_weapons pushback _veh };
} foreach static_vehicles;

// ********************************************************************************************************
// *** CIVILIAN ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_civ.sqf", GRLIB_mod_west];

// *** INDEPENDENT ***
ind_recyclable = [
	["I_HMG_01_high_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_GMG_01_high_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_static_AA_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_static_AT_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_Mortar_01_F",0,round (300 / GRLIB_recycling_percentage),0],
	["I_Truck_02_covered_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_Truck_02_transport_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_Heli_light_03_dynamicLoadout_F",0,round (20 / GRLIB_recycling_percentage),0]
];

// *** MILITIA ***
[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";
if ( isNil "militia_squad" ) then {
	militia_squad = [
		"O_G_Soldier_SL_F",
		"O_G_Soldier_A_F",
		"O_G_Soldier_AR_F",
		"O_G_Soldier_AR_F",	
		"O_G_medic_F",
		"O_G_engineer_F",
		"O_G_Soldier_exp_F",
		"O_G_Soldier_GL_F",
		"O_G_Soldier_M_F",
		"O_G_Soldier_F",
		"O_G_Soldier_LAT_F",
		"O_G_Soldier_LAT_F",	
		"O_G_Soldier_lite_F",
		"O_G_Sharpshooter_F",
		"O_G_Soldier_TL_F",
		"O_Soldier_AA_F",
		"O_Soldier_AT_F"
	];
};

if ( isNil "militia_loadout_overide" ) then {
	militia_loadout_overide = [
		"O_Soldier_AA_F",
		"O_Soldier_AT_F"
	];
};

if ( isNil "militia_vehicles" ) then {
	militia_vehicles = [
		"O_G_Offroad_01_armed_F",
		"O_G_Offroad_01_armed_F",
		"O_G_Offroad_01_AT_F",
		"I_C_Offroad_02_LMG_F",
		"O_LSV_02_armed_F",
		"O_LSV_02_AT_F"
	];
};

// *** SIMPLE OBJECTS ***
simple_objects = [
	"Land_ClutterCutter_large_F",
	"Land_PortableHelipadLight_01_F"
];

// *** ELITE Vehicles ***
elite_vehicles = [];
{ if (_x select 4 == GRLIB_perm_max) then { elite_vehicles pushback (_x select 0)} } foreach heavy_vehicles_west + air_vehicles_west + heavy_vehicles_east + air_vehicles_east;

// *** UAVs ***
uavs = uavs_west + uavs_east;

// *** Boats ***
boats_names = [ 
	"B_Boat_Transport_01_F",
	"C_Boat_Transport_02_F",
	"B_Boat_Armed_01_minigun_F"
] + opfor_boats;

// Big_units
vehicle_big_units = [
	"Land_Cargo_Tower_V1_F",
	"B_T_VTOL_01_infantry_F",
	"B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_armed_F",
	"O_T_VTOL_01_infantry_F",
	"O_T_VTOL_01_vehicle_F",
	"O_T_VTOL_01_armed_F",
	"Land_SM_01_shed_F",
	"Land_Hangar_F"
] + vehicle_big_units_west;

// *** LRX - A3W ***
if ( isNil "guard_squad" ) then {
	guard_squad = [
		"O_GEN_Commander_F",
		"O_GEN_Soldier_F",
		"O_GEN_Soldier_F",
		"O_GEN_Soldier_F",
		"O_GEN_Soldier_F"
	];
};
if ( isNil "guard_loadout_overide" ) then {
	guard_loadout_overide = [
		"O_GEN_Commander_F"
	];
};

if ( isNil "divers_squad" ) then {
	divers_squad = [
		"O_diver_TL_F",
		"O_diver_TL_F",
		"O_diver_exp_F",
		"O_diver_exp_F",
		"O_diver_exp_F",
		"O_diver_F",
		"O_diver_F",
		"O_diver_F",
		"O_diver_F",
		"O_diver_F"
	];
};

if ( isNil "resistance_squad" ) then {
	resistance_squad = [
		"I_G_Soldier_SL_F",
		"I_G_Soldier_A_F",
		"I_G_Soldier_AR_F",
		"I_G_medic_F",
		"I_G_Soldier_exp_F",
		"I_G_Soldier_GL_F",
		"I_G_Soldier_M_F",
		"I_G_Soldier_F",
		"I_G_Soldier_LAT_F",
		"I_G_Soldier_lite_F",
		"I_G_Sharpshooter_F",
		"I_G_Soldier_TL_F"
	];
};

if ( isNil "resistance_squad_static" ) then {
	resistance_squad_static = "I_static_AA_F";
};

// *** TRANSPORT CONFIG ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_transport.sqf", GRLIB_mod_west];
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_transport.sqf", GRLIB_mod_east];
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_transport.sqf", GRLIB_mod_indp];

transport_vehicles = [];
{transport_vehicles pushBack (_x select 0)} foreach (box_transport_config);
box_transport_loadable = [];
{box_transport_loadable pushBack (_x select 0)} foreach (box_transport_offset);

// Whitelist Vehicle (recycle)
GRLIB_vehicle_whitelist = [
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	mobile_respawn,
	A3W_BoxWps,
	canister_fuel_typename,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	medicalbox_typename
] + GRLIB_vehicle_whitelist + opfor_statics;

// Blacklist Vehicle (lock and paint)
GRLIB_vehicle_blacklist = [
	FOB_sign,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	canister_fuel_typename,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	medicalbox_typename,
	fireworks_typename
] +  GRLIB_vehicle_blacklist;

// Recycleable objects
GRLIB_recycleable_blacklist = [FOB_sign];
GRLIB_recycleable_classnames = ["LandVehicle","Air","Ship","StaticWeapon","Slingload_01_Base_F","Pod_Heli_Transport_04_base_F"];
{
	if (!((_x select 0) in GRLIB_recycleable_blacklist)) then {GRLIB_recycleable_classnames pushBack (_x select 0)};
} foreach (support_vehicles + buildings + opfor_recyclable);

// Filter Mods
militia_squad = [ militia_squad , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
militia_vehicles = [ militia_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_vehicles = [ opfor_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_vehicles_low_intensity = [ opfor_vehicles_low_intensity , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_battlegroup_vehicles = [ opfor_battlegroup_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_battlegroup_vehicles_low_intensity = [ opfor_battlegroup_vehicles_low_intensity , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_troup_transports_truck = [ opfor_troup_transports_truck , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_troup_transports_heli = [ opfor_troup_transports_heli , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_air = [ opfor_air , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
civilians = [ civilians , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
civilian_vehicles = [ civilian_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
military_alphabet = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mike","November","Oscar","Papa","Quebec","Romeo","Sierra","Tango","Uniform","Victor","Whiskey","X-Ray","Yankee","Zulu"];

opfor_squad_low_intensity = [
	opfor_squad_leader,
	opfor_medic,
	opfor_rpg,
	opfor_sentry,
	opfor_sentry,
	opfor_sentry,
	opfor_sentry
];
opfor_squad_8_standard = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_rpg,
	opfor_heavygunner,
	opfor_marksman,
	opfor_marksman,
	opfor_grenadier
];
opfor_squad_8_infkillers = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_heavygunner,
	opfor_marksman,
	opfor_sharpshooter,
	opfor_sniper,
	opfor_rpg
];
opfor_squad_8_tankkillers = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_rpg,
	opfor_rpg,
	opfor_at,
	opfor_at,
	opfor_at
];
opfor_squad_8_airkillers = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_rpg,
	opfor_rpg,
	opfor_aa,
	opfor_aa,
	opfor_aa
];
all_resistance_troops = [] + militia_squad;
all_hostile_classnames = (opfor_vehicles + opfor_vehicles_low_intensity + opfor_air + opfor_troup_transports_heli + opfor_troup_transports_truck + opfor_boats);
markers_reset = [99999,99999,0];
zeropos = [0,0,0];
squads_names = [ localize "STR_LIGHT_RIFLE_SQUAD", localize "STR_RIFLE_SQUAD", localize "STR_AT_SQUAD", localize "STR_AA_SQUAD", localize "STR_MIXED_SQUAD", localize "STR_RECON_SQUAD" ];
ammobox_transports_typenames = [];
{ ammobox_transports_typenames pushback (_x select 0) } foreach box_transport_config;
ammobox_transports_typenames = [ ammobox_transports_typenames , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
elite_vehicles = [ elite_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_infantry = [opfor_sentry,opfor_rifleman,opfor_grenadier,opfor_squad_leader,opfor_team_leader,opfor_marksman,opfor_machinegunner,opfor_heavygunner,opfor_medic,opfor_rpg,opfor_at,opfor_aa,opfor_officer,opfor_sharpshooter,opfor_sniper,opfor_engineer];
GRLIB_rank_level = ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];
GRLIB_intel_table = "Land_CampingTable_small_F";
GRLIB_intel_chair = "Land_CampingChair_V2_F";
GRLIB_intel_file = "Land_File1_F";
GRLIB_intel_laptop = "Land_Laptop_device_F";
GRLIB_ignore_colisions = [
	huron_typename,
	Arsenal_typename,
	mobile_respawn,
	canister_fuel_typename,
	medicalbox_typename,
	fireworks_typename,
	"Helper_Base_F",
	"Blood_01_Base_F",
	"MedicalGarbage_01_Base_F",
  	"ReammoBox_F",
	"StaticMGWeapon",
	"StaticGrenadeLauncher",
	"StaticMortar",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_BLUFOR_big_F",
	"Land_NavigLight",
	"Lamps_base_F",
	"Land_HelipadSquare_F",
	"PowerLines_base_F",
	"PowerLines_Small_base_F",
	"PowerLines_Wires_base_F",
	"Land_ClutterCutter_large_F",
 	"Land_PowLine_wire_BB_EP1",
 	"Land_PowLine_wire_AB_EP1",
 	"Land_PowLine_wire_A_left_EP1",
 	"Land_PowLine_wire_A_right_EP1"
];
GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F";
GRLIB_sar_fire = "test_EmptyObjectForFireBig";
// Ammobox you want keep contents
GRLIB_Ammobox_keep = [
	A3W_BoxWps,
	medicalbox_typename,
	"Box_NATO_WpsLaunch_F",
	"mission_USLaunchers",
	"Land_CargoBox_V1_F"
];

GRLIB_player_grave = [
	"Land_Grave_rocks_F",
	"Land_Grave_forest_F",
	"Land_Grave_dirt_F"
];
GRLIB_player_gravebox = "Land_PlasticCase_01_small_black_F";

// Air Drop Support
if ( isNil "GRLIB_AirDrop_Taxi_cost" ) then {
	GRLIB_AirDrop_Taxi_cost = 100;
};

if ( isNil "GRLIB_AirDrop_Vehicle_cost" ) then {
	GRLIB_AirDrop_Vehicle_cost = 200;
};

if ( isNil "GRLIB_AirDrop_1" ) then {
	GRLIB_AirDrop_1 = [
		"I_Quadbike_01_F",
		"I_G_Offroad_01_F",
		"I_G_Quadbike_01_F",
		"C_Offroad_01_F",
		"B_G_Offroad_01_F"
	];
};
if ( isNil "GRLIB_AirDrop_1_cost" ) then {
	GRLIB_AirDrop_1_cost = 50;
};

if ( isNil "GRLIB_AirDrop_2" ) then {
	GRLIB_AirDrop_2 = [
		"I_G_Offroad_01_armed_F",
		"B_G_Offroad_01_armed_F",
		"O_G_Offroad_01_armed_F",
		"I_C_Offroad_02_LMG_F"
	];
};
if ( isNil "GRLIB_AirDrop_2_cost" ) then {
	GRLIB_AirDrop_2_cost = 100;
};

if ( isNil "GRLIB_AirDrop_3" ) then {	
	GRLIB_AirDrop_3 = [
		"I_MRAP_03_hmg_F",
		"I_MRAP_03_gmg_F",
		"B_T_MRAP_01_hmg_F",
		"B_T_MRAP_01_gmg_F"
	];
};
if ( isNil "GRLIB_AirDrop_3_cost" ) then {
	GRLIB_AirDrop_3_cost = 200;
};

if ( isNil "GRLIB_AirDrop_4" ) then {	
	GRLIB_AirDrop_4 = [
		"B_Truck_01_transport_F",
		"B_Truck_01_covered_F",
		"I_Truck_02_covered_F",
		"I_Truck_02_transport_F"
	];
};
if ( isNil "GRLIB_AirDrop_4_cost" ) then {
	GRLIB_AirDrop_4_cost = 300;
};

if ( isNil "GRLIB_AirDrop_5" ) then {	
	GRLIB_AirDrop_5 = [
		"I_APC_tracked_03_cannon_F",
		"B_APC_Wheeled_03_cannon_F",
		"B_APC_Wheeled_01_cannon_F"
	];
};
if ( isNil "GRLIB_AirDrop_5_cost" ) then {
	GRLIB_AirDrop_5_cost = 750;
};

if ( isNil "GRLIB_AirDrop_6" ) then {	
	GRLIB_AirDrop_6 = [
		"C_Boat_Civil_01_F",
		"C_Boat_Transport_02_F",
		"B_Boat_Transport_01_F",
		"I_C_Boat_Transport_02_F"
	];
};
if ( isNil "GRLIB_AirDrop_6_cost" ) then {
	GRLIB_AirDrop_6_cost = 250;
};
if ( isNil "GRLIB_AirDrop_7_cost" ) then {
	GRLIB_AirDrop_7_cost = 2000;
};
