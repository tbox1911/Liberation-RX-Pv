// All Object classname used in RX must be declared here

if ( isNil "Arsenal_typename" ) then { Arsenal_typename = "B_supplyCrate_F" };
if ( isNil "mobile_respawn" ) then { mobile_respawn = "Land_TentDome_F" };		// "Land_SatelliteAntenna_01_F"
if ( isNil "mobile_respawn_bag" ) then { mobile_respawn_bag = "B_Kitbag_Base" };
if ( isNil "medicalbox_typename" ) then { medicalbox_typename = "Box_B_UAV_06_medical_F" };
if ( isNil "ammobox_b_typename" ) then { ammobox_b_typename = "Box_NATO_AmmoVeh_F" };
if ( isNil "ammobox_o_typename" ) then { ammobox_o_typename = "Box_East_AmmoVeh_F" };
if ( isNil "ammobox_i_typename" ) then { ammobox_i_typename = "Box_IND_AmmoVeh_F" };
if ( isNil "waterbarrel_typename" ) then { waterbarrel_typename = "Land_BarrelWater_F" };
if ( isNil "fuelbarrel_typename" ) then { fuelbarrel_typename = "Land_MetalBarrel_F" };
if ( isNil "foodbarrel_typename" ) then { foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F" };
if ( isNil "PAR_Medikit" ) then { PAR_Medikit = "Medikit" };
if ( isNil "PAR_AidKit" ) then { PAR_AidKit = "FirstAidKit" };
if ( isNil "A3W_BoxWps" ) then { A3W_BoxWps = "Box_East_Wps_F" };
if ( isNil "canisterFuel" ) then { canisterFuel = "Land_CanisterFuel_Red_F" };
if ( isNil "opfor_ammobox_transport" ) then { opfor_ammobox_transport = "I_Truck_02_transport_F" };

// *** BUILDINGS ***
buildings = [
	["Land_PierLadder_F",0,0,0,GRLIB_perm_inf],
	["Land_CncBarrierMedium4_F",0,0,0,0],
	["Land_CncWall4_F",0,0,0,0],
	["Land_BagFence_Round_F",0,0,0,GRLIB_perm_log],
	["Land_BagFence_Long_F",0,0,0,0],
	["Land_BagFence_Short_F",0,0,0,GRLIB_perm_inf],
	["Land_BagFence_Corner_F",0,0,0,GRLIB_perm_log],
	["Land_HBarrier_5_F",0,0,0,0],
	["Land_HBarrierWall4_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall6_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall_corner_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierTower_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierBig_F",0,0,0,GRLIB_perm_tank],
	["Land_CncShelter_F",0,0,0,GRLIB_perm_log],
	["Land_BagBunker_Small_F",0,0,0,0],
	["Land_BagBunker_Large_F",0,0,0,GRLIB_perm_tank],
	["Land_BagBunker_Tower_F",0,0,0,GRLIB_perm_tank],
	["Land_SM_01_shed_F",0,0,0,GRLIB_perm_max],
	["Land_Hangar_F",0,0,0,GRLIB_perm_max],
	["Land_PortableLight_double_F",0,0,0,GRLIB_perm_log],
	["Land_LampHalogen_F",0,0,0,GRLIB_perm_tank],
	["Land_HelipadSquare_F",0,0,0,GRLIB_perm_log],
	["Land_Razorwire_F",0,0,0,GRLIB_perm_tank],
	["Land_ToolTrolley_02_F",0,0,0,GRLIB_perm_tank],
	["Land_WeldingTrolley_01_F",0,0,0,GRLIB_perm_tank],
	["Land_GasTank_02_F",0,0,0,GRLIB_perm_tank],
	["Land_Workbench_01_F",0,0,0,GRLIB_perm_tank],
	["Land_WaterTank_F",0,0,0,GRLIB_perm_tank],
	["Land_WaterBarrel_F",0,0,0,GRLIB_perm_tank],
	["Land_BarGate_F",0,0,0,GRLIB_perm_log],
	["Land_MetalCase_01_large_F",0,0,0,GRLIB_perm_tank],
	["CargoNet_01_box_F",0,0,0,GRLIB_perm_tank],
	["CamoNet_BLUFOR_open_F",0,0,GRLIB_perm_tank],
	["CamoNet_BLUFOR_big_F",0,0,0,GRLIB_perm_tank],
	["Land_CampingChair_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_CampingChair_V2_F",0,0,0,GRLIB_perm_tank],
	["Land_CampingTable_F",0,0,0,GRLIB_perm_tank],
	["MapBoard_altis_F",0,0,0,GRLIB_perm_tank],
	["Land_Metal_rack_Tall_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_blue_F",0,0,0,GRLIB_perm_tank],
	["Land_DieselGroundPowerUnit_01_F",0,0,0,GRLIB_perm_tank],
	["Land_Pallet_MilBoxes_F",0,0,0,GRLIB_perm_tank],
	["Land_PaperBox_open_full_F",0,0,0,GRLIB_perm_tank],
	["Land_ClutterCutter_large_F",0,0,0,GRLIB_perm_tank],
	["Land_CzechHedgehog_01_new_F",0,0,0,GRLIB_perm_inf]
];

// *** FRIENDLIES ***
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames_west.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames_east.sqf";

// *** ELITE Vehicles ***
elite_vehicles = [];
{ if (_x select 4 == GRLIB_perm_max) then { elite_vehicles pushback (_x select 0)} } foreach heavy_vehicles_west + air_vehicles_west + heavy_vehicles_east + air_vehicles_east;


// Everything the AI troups should be able to resupply from
ai_resupply_sources = [
	Arsenal_typename,
	ammo_truck_typename_west,
	ammo_sling_typename_west,
	ammo_truck_typename_east,
	ammo_sling_typename_east,
	"B_APC_Tracked_01_CRV_F"
];

// Everything the AI troups should be able to healing from
ai_healing_sources = [
	medicalbox_typename,
	Respawn_truck_typename_west,
	medic_sling_typename_west,
	Respawn_truck_typename_east,
	medic_sling_typename_east,
	"B_APC_Tracked_01_CRV_F"
];

vehicle_rearm_sources = [
	ammo_truck_typename_west,
	ammo_sling_typename_west,
	ammo_truck_typename_east,
	ammo_sling_typename_east,
	"B_APC_Tracked_01_CRV_F",
	"Box_NATO_Ammo_F"
];

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
];


// *** BADDIES ***

if ( isNil "opfor_sentry") then { opfor_sentry = "I_Soldier_lite_F" };
if ( isNil "opfor_rifleman") then { opfor_rifleman = "I_Soldier_F" };
if ( isNil "opfor_grenadier") then { opfor_grenadier = "I_Soldier_GL_F" };
if ( isNil "opfor_squad_leader") then { opfor_squad_leader = "I_Soldier_SL_F" };
if ( isNil "opfor_team_leader") then { opfor_team_leader = "I_Soldier_TL_F" };
if ( isNil "opfor_marksman") then { opfor_marksman = "I_soldier_M_F" };
if ( isNil "opfor_machinegunner") then { opfor_machinegunner = "I_Soldier_AR_F" };
if ( isNil "opfor_heavygunner") then { opfor_heavygunner = "I_Soldier_AR_F" };
if ( isNil "opfor_medic") then { opfor_medic = "I_medic_F" };
if ( isNil "opfor_rpg") then { opfor_rpg = "I_Soldier_LAT_F" };
if ( isNil "opfor_at") then { opfor_at = "I_Soldier_AT_F" };
if ( isNil "opfor_aa") then { opfor_aa = "I_Soldier_AA_F" };
if ( isNil "opfor_officer") then { opfor_officer = "I_officer_F" };
if ( isNil "opfor_sharpshooter") then { opfor_sharpshooter = "I_Soldier_M_F" };
if ( isNil "opfor_sniper") then { opfor_sniper = "I_sniper_F" };
if ( isNil "opfor_engineer") then { opfor_engineer = "I_engineer_F" };
if ( isNil "opfor_pilot" ) then { opfor_pilot = "I_Pilot_F" };
if ( isNil "opfor_paratrooper") then { opfor_paratrooper = "I_soldier_PG_F" };
if ( isNil "opfor_mrap") then { opfor_mrap = "I_MRAP_02_F" };
if ( isNil "opfor_mrap_hmg") then { opfor_mrap_hmg = "I_MRAP_02_hmg_F" };
if ( isNil "opfor_mrap_gmg") then { opfor_mrap_gmg = "I_MRAP_02_gmg_F" };
if ( isNil "opfor_transport_helo") then { opfor_transport_helo = "I_Heli_Transport_04_bench_F" };
if ( isNil "opfor_transport_truck") then { opfor_transport_truck = "I_Truck_03_covered_F" };
if ( isNil "opfor_fuel_truck") then { opfor_fuel_truck = "I_Truck_03_fuel_F" };
if ( isNil "opfor_ammo_truck") then { opfor_ammo_truck = "I_Truck_03_ammo_F" };
if ( isNil "opfor_fuel_container") then { opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F" };
if ( isNil "opfor_ammo_container") then { opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F" };
if ( isNil "opfor_flag") then { opfor_flag = "Flag_CSAT_F" };

militia_squad = [
	"I_G_Soldier_SL_F",
	"I_G_Soldier_A_F",
	"I_G_Soldier_AR_F",
	"I_G_medic_F",
	"I_G_engineer_F",
	"I_G_Soldier_exp_F",
	"I_G_Soldier_GL_F",
	"I_G_Soldier_M_F",
	"I_G_Soldier_F",
	"I_G_Soldier_LAT_F",
	"I_G_Soldier_lite_F",
	"I_G_Sharpshooter_F",
	"I_G_Soldier_TL_F",
	"I_Soldier_AA_F",
	"I_Soldier_AT_F"
];

divers_squad = [
	"I_diver_TL_F",
	"I_diver_TL_F",
	"I_diver_exp_F",
	"I_diver_exp_F",
	"I_diver_exp_F",
	"I_diver_exp_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F"
];

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

militia_vehicles = [
	"I_G_Offroad_01_armed_F",
	"I_G_Offroad_01_armed_F",
	"I_G_Offroad_01_AT_F",
	"I_C_Offroad_02_LMG_F",
	"O_LSV_02_armed_F",
	"O_LSV_02_AT_F"
];

opfor_boat = [
	"I_Boat_Armed_01_minigun_F"
];

opfor_vehicles = [
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"I_LT_01_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_APC_tracked_03_cannon_F",
	"I_MBT_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F"
];

opfor_vehicles_low_intensity = [
	"I_C_Offroad_02_LMG_F",
	"I_C_Offroad_02_AT_F",
	"I_G_Offroad_01_AT_F",
	"I_G_Offroad_01_armed_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"I_Heli_Transport_02_F",
	"I_Truck_02_covered_F"
];

opfor_battlegroup_vehicles = [
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"I_LT_01_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_APC_tracked_03_cannon_F",
	"I_MBT_03_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"I_Heli_Transport_02_F",
	"I_Truck_02_covered_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"I_LT_01_cannon_F",
	"I_C_Offroad_02_LMG_F",
	"I_C_Offroad_02_AT_F",
	"I_G_Offroad_01_AT_F",
	"I_G_Offroad_01_armed_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"I_Heli_Transport_02_F",
	"I_Truck_02_covered_F"
];

opfor_troup_transports = [
	"I_Heli_Transport_02_F",
	"I_Truck_02_covered_F",
	"I_Truck_02_transport_F"
];

opfor_choppers = [
	"I_Heli_Transport_02_F",
	"I_Heli_light_03_F",
	"I_Plane_Fighter_04_F"
];

opfor_air = [
	"I_Heli_light_03_F",
	"I_Plane_Fighter_03_CAS_F",
	"I_Plane_Fighter_04_F"
];

opfor_statics = [
	"I_HMG_01_high_F",
	"I_GMG_01_high_F",
	"I_static_AA_F",
	"I_static_AT_F",
	"I_Mortar_01_F"
];

opfor_texture_overide = [
	//"Urban",
	//"Digital"
];

opfor_recyclable = [
	["I_MRAP_03_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_MRAP_03_hmg_F",0,round (50 / GRLIB_recycling_percentage),0],
	["I_MRAP_03_gmg_F",0,round (70 / GRLIB_recycling_percentage),0],

	["I_HMG_01_high_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_GMG_01_high_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_static_AA_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_static_AT_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_Mortar_01_F",0,round (300 / GRLIB_recycling_percentage),0],

	["I_LT_01_AT_F",1,round (20 / GRLIB_recycling_percentage),2],
	["I_LT_01_AA_F",1,round (40 / GRLIB_recycling_percentage),2],
	["I_LT_01_cannon_F",1,round (30 / GRLIB_recycling_percentage),2],

	["I_C_Offroad_02_LMG_F",1,round (40 / GRLIB_recycling_percentage),2],
	["I_C_Offroad_02_AT_F",1,round (30 / GRLIB_recycling_percentage),2],
	["I_G_Offroad_01_AT_F",1,round (30 / GRLIB_recycling_percentage),2],
	["I_G_Offroad_01_armed_F",1,round (30 / GRLIB_recycling_percentage),2],

	["I_Truck_02_covered_F",5,round (20 / GRLIB_recycling_percentage),5],
	["I_Truck_02_transport_F",5,round (20 / GRLIB_recycling_percentage),5],

	// ["I_Truck_03_covered_F",5,round (50 / GRLIB_recycling_percentage),5],
	// ["I_Truck_03_transport_F",5,round (50 / GRLIB_recycling_percentage),5],
	// ["I_MRAP_02_hmg_F",5,round (50 / GRLIB_recycling_percentage),3],
	// ["I_MRAP_02_gmg_F",5,round (50 / GRLIB_recycling_percentage),3],
	["I_Boat_Armed_01_minigun_F",2,round (100 / GRLIB_recycling_percentage),2],
	// ["I_T_Boat_Armed_01_hmg_F",2,round (100 / GRLIB_recycling_percentage),2],
	// ["I_APC_Wheeled_02_rcws_F",10,round (150 / GRLIB_recycling_percentage),10],
	// ["I_APC_Tracked_02_cannon_F",10,round (200 / GRLIB_recycling_percentage),10],
	// ["I_APC_Tracked_02_AA_F",10,round (300 / GRLIB_recycling_percentage),10],

	["I_APC_Wheeled_03_cannon_F",15,round (400 / GRLIB_recycling_percentage),15],
	["I_APC_tracked_03_cannon_F",15,round (500 / GRLIB_recycling_percentage),15],
	["I_MBT_03_cannon_F",15,round (800 / GRLIB_recycling_percentage),15],
	["I_Heli_light_03_F",10,round (700 / GRLIB_recycling_percentage),15],
	["I_Heli_Transport_02_F",10,round (500 / GRLIB_recycling_percentage),10],
	["I_Plane_Fighter_03_CAS_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["I_Plane_Fighter_04_F",20,round (1000 / GRLIB_recycling_percentage),30]
];


// *** CIVILIANS ***

civilians = [
	"C_Orestes",
	"C_Nikos",
	"C_Nikos_aged",
	"C_man_1",
	"C_man_polo_6_F",
	"C_man_polo_3_F",
	"C_man_polo_2_F",
	"C_man_polo_4_F",
	"C_man_polo_5_F",
	"C_man_polo_1_F",
	"C_man_p_beggar_F",
	"C_man_1_2_F",
	"C_man_p_fugitive_F",
	"C_man_hunter_1_F",
	"C_Man_Fisherman_01_F",
	"C_man_sport_1_F",
	"C_man_sport_3_F",
	"C_man_sport_2_F",
	"C_Man_Messenger_01_F",
	"C_Story_Mechanic_01_F",
	"C_Man_casual_2_F",
	"C_Man_casual_4_F",
	"C_Man_casual_1_F",
	"C_Man_casual_3_F",
	"C_Man_casual_5_F",
	"C_journalist_F",
	"C_man_shorts_2_F",
	"C_man_w_worker_F",
	"C_Paramedic_01_base_F",
	"C_Man_UAV_06_F",
	"C_Man_UtilityWorker_01_F"
];

civilian_vehicles = [
	"C_Quadbike_01_F",
	"C_Heli_light_01_sheriff_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_light_01_furious_F",
	"C_Heli_light_01_graywatcher_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_Quadbike_01_F",
	"C_Offroad_01_F",
	"C_Offroad_01_darkred_F",
	"C_Offroad_luxe_F",
	"C_Offroad_02_unarmed_F",
	"C_Offroad_01_covered_F",
	"C_Offroad_01_comms_F",
	"I_C_Offroad_02_unarmed_F",
	"C_Quadbike_01_F",
	"SUV_01_base_black_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F",
	"C_Van_01_fuel_F",
	"C_Quadbike_01_F",
	"C_Van_02_transport_F",
	"C_Van_02_medevac_F",
	"C_Van_02_service_F",
	"B_GEN_Van_02_transport_F",
	"C_Truck_02_covered_F",
	"C_Truck_02_transport_F",
	"C_Tractor_01_F"
];

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
];
transport_vehicles = [];
{transport_vehicles pushBack ( _x select 0 )} foreach (box_transport_config);

// Whitelist Vehicle (recycle)
GRLIB_vehicle_whitelist = [
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
//{GRLIB_vehicle_whitelist pushBack ( _x select 0 )} foreach (support_vehicles);


// Blacklist Vehicle (lock and paint)
GRLIB_vehicle_blacklist = [
	Arsenal_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	//mobile_respawn,
	opfor_ammobox_transport,
	FOB_box_typename_west,
	FOB_truck_typename_west,
	FOB_box_typename_east,
	FOB_truck_typename_east,
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
	"Box_NATO_Ammo_F",
  	"Box_NATO_WpsLaunch_F",
	"Land_CargoBox_V1_F"
];
//{GRLIB_vehicle_blacklist pushBack ( _x select 0 )} foreach (support_vehicles);

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
boats_names = [ "B_Boat_Transport_01_F", "C_Boat_Transport_02_F", "I_Boat_Armed_01_minigun_F" ];
ammobox_transports_typenames = [];
{ ammobox_transports_typenames pushback (_x select 0) } foreach box_transport_config;
ammobox_transports_typenames = [ ammobox_transports_typenames , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
elite_vehicles = [ elite_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_infantry = [opfor_sentry,opfor_rifleman,opfor_grenadier,opfor_squad_leader,opfor_team_leader,opfor_marksman,opfor_machinegunner,opfor_heavygunner,opfor_medic,opfor_rpg,opfor_at,opfor_aa,opfor_officer,opfor_sharpshooter,opfor_sniper,opfor_engineer];
GRLIB_intel_table = "Land_CampingTable_small_F";
GRLIB_intel_chair = "Land_CampingChair_V2_F";
GRLIB_intel_file = "Land_File1_F";
GRLIB_intel_laptop = "Land_Laptop_device_F";
GRLIB_ignore_colisions_objects = [
	Arsenal_typename,
	mobile_respawn,
	canisterFuel,
	medicalbox_typename,
	"Box_NATO_Ammo_F",
  	"Box_NATO_WpsLaunch_F",
	"Land_CargoBox_V1_F",
	"B_HMG_01_F",
	"B_HMG_01_high_F",
	"B_GMG_01_F",
	"B_GMG_01_high_F",
	"B_static_AA_F",
	"B_static_AT_F",
	"B_Mortar_01_F",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_BLUFOR_big_F",
	"Land_Flush_Light_red_F",
	"Land_Flush_Light_green_F",
	"Land_Flush_Light_yellow_F",
	"Land_runway_edgelight",
	"Land_runway_edgelight_blue_F",
	"Land_HelipadSquare_F",
	"Sign_Sphere100cm_F",
	"Land_ClutterCutter_large_F",
 	"Land_PowLine_wire_BB_EP1",
 	"Land_PowLine_wire_AB_EP1",
 	"Land_PowLine_wire_A_left_EP1",
 	"Land_PowLine_wire_A_right_EP1"
];
GRLIB_ignore_colisions_classes = [
	"PowerLines_base_F",
	"PowerLines_Small_base_F",
	"PowerLines_Wires_base_F"
];

GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F";
GRLIB_sar_fire = "test_EmptyObjectForFireBig";
GRLIB_Ammobox = [
	A3W_BoxWps,
	medicalbox_typename,
	"Box_NATO_Ammo_F",
	"Box_NATO_WpsLaunch_F",
	"mission_USLaunchers",
	"Land_CargoBox_V1_F"
];
GRLIB_AirDrop_1 = [
	"I_Quadbike_01_F",
	"I_G_Offroad_01_F",
	"I_G_Quadbike_01_F",
	"C_Offroad_01_F",
	"B_G_Offroad_01_F"
];
GRLIB_AirDrop_2 = [
	"I_G_Offroad_01_armed_F",
	"B_G_Offroad_01_armed_F",
	"O_G_Offroad_01_armed_F",
	"I_C_Offroad_02_LMG_F"
];
GRLIB_AirDrop_3 = [
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F"
];
GRLIB_AirDrop_4 = [
	"B_Truck_01_transport_F",
	"B_Truck_01_covered_F",
	"I_Truck_02_covered_F",
	"I_Truck_02_transport_F"
];
GRLIB_AirDrop_5 = [
	"I_APC_tracked_03_cannon_F",
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F"
];
GRLIB_AirDrop_6 = [
	"C_Boat_Civil_01_F",
	"C_Boat_Transport_02_F",
	"B_Boat_Transport_01_F",
	"I_C_Boat_Transport_02_F"
];

GRLIB_player_grave = [
	"Land_Grave_rocks_F",
	"Land_Grave_forest_F",
	"Land_Grave_dirt_F"
];
