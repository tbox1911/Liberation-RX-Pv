// Global objects
if ( isNil "Arsenal_typename" ) then { Arsenal_typename = "B_supplyCrate_F" };
if ( isNil "FOB_typename" ) then { FOB_typename = "Land_Cargo_HQ_V1_F" };
if ( isNil "FOB_box_typename" ) then { FOB_box_typename = "B_Slingload_01_Cargo_F" };
if ( isNil "FOB_truck_typename" ) then { FOB_truck_typename = "B_Truck_01_box_F" };
if ( isNil "FOB_outpost" ) then { FOB_outpost = "Land_BagBunker_Tower_F" };
if ( isNil "FOB_box_outpost" ) then { FOB_box_outpost = "Land_Cargo10_grey_F" };
if ( isNil "Respawn_truck_typename" ) then { Respawn_truck_typename = "B_Truck_01_medical_F" };
if ( isNil "ammo_truck_typename" ) then { ammo_truck_typename = "B_Truck_01_ammo_F" };
if ( isNil "fuel_truck_typename" ) then { fuel_truck_typename = "B_Truck_01_fuel_F" };
if ( isNil "repair_truck_typename" ) then { repair_truck_typename = "B_Truck_01_Repair_F" };
if ( isNil "repair_sling_typename" ) then { repair_sling_typename = "B_Slingload_01_Repair_F" };
if ( isNil "fuel_sling_typename" ) then { fuel_sling_typename = "B_Slingload_01_Fuel_F" };
if ( isNil "ammo_sling_typename" ) then { ammo_sling_typename = "B_Slingload_01_Ammo_F" };
if ( isNil "medic_sling_typename" ) then { medic_sling_typename = "B_Slingload_01_Medevac_F" };
if ( isNil "mobile_respawn" ) then { mobile_respawn = "Land_TentDome_F" };		// "Land_SatelliteAntenna_01_F"
if ( isNil "mobile_respawn_bag" ) then { mobile_respawn_bag = "B_Kitbag_Base" };
if ( isNil "medicalbox_typename" ) then { medicalbox_typename = "Box_B_UAV_06_medical_F" };
if ( isNil "huron_typename" ) then { huron_typename = "B_Heli_Transport_03_unarmed_F" };
if ( isNil "ammobox_b_typename" ) then { ammobox_b_typename = "Box_NATO_AmmoVeh_F" };
if ( isNil "ammobox_o_typename" ) then { ammobox_o_typename = "Box_East_AmmoVeh_F" };
if ( isNil "ammobox_i_typename" ) then { ammobox_i_typename = "Box_IND_AmmoVeh_F" };
if ( isNil "waterbarrel_typename" ) then { waterbarrel_typename = "Land_BarrelWater_F" };
if ( isNil "fuelbarrel_typename" ) then { fuelbarrel_typename = "Land_MetalBarrel_F" };
if ( isNil "foodbarrel_typename" ) then { foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F" };
if ( isNil "commander_classname" ) then { commander_classname = "B_officer_F" };
if ( isNil "crewman_classname" ) then { crewman_classname = "B_crew_F" };
if ( isNil "pilot_classname" ) then { pilot_classname = "B_Helipilot_F" };
if ( isNil "PAR_Medikit" ) then { PAR_Medikit = "Medikit" };
if ( isNil "PAR_AidKit" ) then { PAR_AidKit = "FirstAidKit" };
if ( isNil "A3W_BoxWps" ) then { A3W_BoxWps = "Box_East_Wps_F" };
if ( isNil "canisterFuel" ) then { canisterFuel = "Land_CanisterFuel_Red_F" };
if ( isNil "uavs" ) then { uavs = [] };
if ( isNil "boats" ) then { boats = [] };
if ( isNil "ai_resupply_sources" ) then { ai_resupply_sources = [] };
if ( isNil "ai_healing_sources" ) then { ai_healing_sources = [] };
if ( isNil "vehicle_rearm_sources" ) then { vehicle_rearm_sources = [] };
if ( isNil "vehicle_big_units" ) then { vehicle_big_units = [] };
if ( isNil "GRLIB_vehicle_whitelist" ) then { GRLIB_vehicle_whitelist = [] };
if ( isNil "GRLIB_vehicle_blacklist" ) then { GRLIB_vehicle_blacklist = [] };
if ( isNil "box_transport_config" ) then { box_transport_config = [] };
if ( isNil "civilians" ) then { civilians = ["C_man_1"] };
if ( isNil "civilian_vehicles" ) then { civilian_vehicles = ["C_SUV_01_F"] };

// Opfor
if ( isNil "opfor_ammobox_transport" ) then { opfor_ammobox_transport = "O_Truck_03_transport_F" };

// *** GLOBAL DEFINITION ***

// *** SUPPORT ***
default_support_vehicles = [
	[Arsenal_typename,0,10,0,0],
	[medicalbox_typename,5,5,0,0],
	[mobile_respawn,10,5,0,0],
	[canisterFuel,0,5,1,0],
	[Respawn_truck_typename,15,150,5,GRLIB_perm_log],
	[repair_sling_typename,10,100,0,GRLIB_perm_log],
	[fuel_sling_typename,0,100,30,GRLIB_perm_log],
	[ammo_sling_typename,0,150,0,GRLIB_perm_log],
	[medic_sling_typename,10,100,0,GRLIB_perm_log],
	[ammo_truck_typename,5,200,10,GRLIB_perm_tank],
	[repair_truck_typename,10,130,10,GRLIB_perm_tank],
	[fuel_truck_typename,5,120,40,GRLIB_perm_tank],
	[FOB_box_outpost,25,500,20,GRLIB_perm_log],
	[FOB_box_typename,50,1500,50,GRLIB_perm_max],
	[FOB_truck_typename,50,1500,50,GRLIB_perm_max],
	["Land_CargoBox_V1_F",0,500,0,GRLIB_perm_max],
	[ammobox_b_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_o_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_i_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[A3W_BoxWps,0,round(150 / GRLIB_recycling_percentage),0,99999],
	[waterbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[fuelbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[foodbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf]
];

// *** BUILDINGS ***
default_buildings = [
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
	//["Land_BagBunker_Tower_F",0,0,0,GRLIB_perm_tank],
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

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"B_AAA_System_01_F",
	"B_SAM_System_02_F",
	"I_E_SAM_System_03_F",
	"O_SAM_System_04_F"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources = [
	Arsenal_typename,
	ammo_truck_typename,
	ammo_sling_typename,
	ammo_truck_typename
];

// Everything the AI troups should be able to healing from
ai_healing_sources = [
	medicalbox_typename,
	Respawn_truck_typename,
	medic_sling_typename
];

vehicle_rearm_sources = [
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	ammo_truck_typename,
	ammo_sling_typename
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