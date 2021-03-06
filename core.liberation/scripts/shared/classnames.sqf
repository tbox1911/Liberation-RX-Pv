// All Object classname used in RX must be declared here

[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";
// *** DEFENSE ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_east.sqf", GRLIB_mod_indp];

// *** DEFAULT ***
[] call compileFinal preprocessFileLineNUmbers format ["scripts\shared\default_classnames.sqf"];

// ********************************************************************************************************
// *** BLUE ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_west.sqf", GRLIB_mod_west];
[infantry_units, GRLIB_side_west] call F_calcUnitsCost;

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
buildings_west = default_buildings + buildings;
support_vehicles_west = default_support_vehicles + support_vehicles;
squads_west = squads;
uavs_west = uavs;

// remap list common (should be sided ?)
static_vehicles_AI append static_vehicles_AI_west;
ai_resupply_sources append ai_resupply_sources_west;
ai_healing_sources append ai_healing_sources_west;
vehicle_rearm_sources append vehicle_rearm_sources_west;
vehicle_big_units append vehicle_big_units_west;
GRLIB_vehicle_whitelist append GRLIB_vehicle_whitelist_west;
GRLIB_vehicle_blacklist append GRLIB_vehicle_blacklist_west;
box_transport_config append box_transport_config_west;

// GRLIB_AirDrop_1 per side
//(maybe cleanup vars ?)

// ********************************************************************************************************
// *** RED ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_west.sqf", GRLIB_mod_east];
[infantry_units, GRLIB_side_east] call F_calcUnitsCost;

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
buildings_east = default_buildings + buildings;
support_vehicles_east = default_support_vehicles + support_vehicles;
squads_east = squads;
uavs_east = uavs;

// remap list common
static_vehicles_AI append static_vehicles_AI_west;
ai_resupply_sources append ai_resupply_sources_west;
ai_healing_sources append ai_healing_sources_west;
vehicle_rearm_sources append vehicle_rearm_sources_west;
vehicle_big_units append vehicle_big_units_west;
GRLIB_vehicle_whitelist append GRLIB_vehicle_whitelist_west;
GRLIB_vehicle_blacklist append GRLIB_vehicle_blacklist_west;
box_transport_config append box_transport_config_west;

// ********************************************************************************************************
// *** CIVILIAN ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_civ.sqf", GRLIB_mod_west];

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
] + opfor_boat + boats;

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

// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries
box_transport_config = [
	[ "C_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "B_G_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "I_G_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "O_G_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "B_Truck_01_transport_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "B_Truck_01_covered_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "C_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "C_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "O_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "O_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "O_Truck_03_transport_F", -6.5, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4] ],
	[ "O_Truck_03_covered_F", -6.5, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4] ],
	[ "C_Van_01_box_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "C_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "B_Heli_Transport_03_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1] ],
	[ "B_Heli_Transport_03_unarmed_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1] ],
	[ "I_Heli_Transport_02_F", -6.5, [0, 4.2, -1.45], [0, 2.5, -1.45], [0, 0.8, -1.45], [0, -0.9, -1.45] ]
] + box_transport_config_west + box_transport_config_east;
transport_vehicles = [];
{transport_vehicles pushBack ( _x select 0 )} foreach (box_transport_config);

// Whitelist Vehicle (recycle)
GRLIB_vehicle_whitelist append [
	Arsenal_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	mobile_respawn,
	opfor_ammobox_transport,
	A3W_BoxWps,
	canisterFuel,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	medicalbox_typename,
	"Land_PierLadder_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncWall4_F",
	"Land_HBarrier_5_F",
	"Land_BagBunker_Small_F",
	"Land_BagFence_Long_F"
] + opfor_statics;

// Blacklist Vehicle (lock and paint)
GRLIB_vehicle_blacklist append [
	Arsenal_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	opfor_ammobox_transport,
	FOB_box_typename_west,
	FOB_truck_typename_west,
	FOB_box_typename_east,
	FOB_truck_typename_east,
	FOB_box_outpost,
	canisterFuel,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	medicalbox_typename,
	repair_sling_typename_west,
	fuel_sling_typename_west,
	ammo_sling_typename_west,
	medic_sling_typename_west,
	repair_sling_typename_east,
	fuel_sling_typename_east,
	ammo_sling_typename_east,
	medic_sling_typename_east,
  	"Box_NATO_WpsLaunch_F",
	"Land_CargoBox_V1_F"
];

militia_squad = [ militia_squad , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
militia_vehicles = [ militia_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_vehicles = [ opfor_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_vehicles_low_intensity = [ opfor_vehicles_low_intensity , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_battlegroup_vehicles = [ opfor_battlegroup_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_battlegroup_vehicles_low_intensity = [ opfor_battlegroup_vehicles_low_intensity , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_troup_transports = [ opfor_troup_transports , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_choppers = [ opfor_choppers , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
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
all_hostile_classnames = (opfor_vehicles + opfor_vehicles_low_intensity + opfor_air + opfor_choppers + opfor_troup_transports + opfor_boat);
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
	Arsenal_typename,
	mobile_respawn,
	canisterFuel,
	medicalbox_typename,
  	"Box_NATO_WpsLaunch_F",
	"Land_CargoBox_V1_F",
	"StaticMGWeapon",
	"StaticGrenadeLauncher",
	"StaticMortar",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_BLUFOR_big_F",
	"Land_Flush_Light_red_F",
	"Land_Flush_Light_green_F",
	"Land_Flush_Light_yellow_F",
	"Land_runway_edgelight",
	"Land_runway_edgelight_blue_F",
	"Land_HelipadSquare_F",
	"Sign_Sphere100cm_F",
	"Sign_Arrow_F",
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

if ( isNil "GRLIB_AirDrop_1" ) then {
	GRLIB_AirDrop_1 = [
		"I_Quadbike_01_F",
		"I_G_Offroad_01_F",
		"I_G_Quadbike_01_F",
		"C_Offroad_01_F",
		"B_G_Offroad_01_F"
	];
};

if ( isNil "GRLIB_AirDrop_2" ) then {
	GRLIB_AirDrop_2 = [
		"I_G_Offroad_01_armed_F",
		"B_G_Offroad_01_armed_F",
		"O_G_Offroad_01_armed_F",
		"I_C_Offroad_02_LMG_F"
	];
};

if ( isNil "GRLIB_AirDrop_3" ) then {	
	GRLIB_AirDrop_3 = [
		"I_MRAP_03_hmg_F",
		"I_MRAP_03_gmg_F",
		"B_T_MRAP_01_hmg_F",
		"B_T_MRAP_01_gmg_F"
	];
};

if ( isNil "GRLIB_AirDrop_4" ) then {	
	GRLIB_AirDrop_4 = [
		"B_Truck_01_transport_F",
		"B_Truck_01_covered_F",
		"I_Truck_02_covered_F",
		"I_Truck_02_transport_F"
	];
};

if ( isNil "GRLIB_AirDrop_5" ) then {	
	GRLIB_AirDrop_5 = [
		"I_APC_tracked_03_cannon_F",
		"B_APC_Wheeled_03_cannon_F",
		"B_APC_Wheeled_01_cannon_F"
	];
};

if ( isNil "GRLIB_AirDrop_6" ) then {	
	GRLIB_AirDrop_6 = [
		"C_Boat_Civil_01_F",
		"C_Boat_Transport_02_F",
		"B_Boat_Transport_01_F",
		"I_C_Boat_Transport_02_F"
	];
};
