// *** LRX DEFAULT CLASSNAMES ***
if ( isNil "huron_typename" ) then { huron_typename = "B_Heli_Transport_03_unarmed_F" };

FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "B_Truck_01_box_F";
FOB_outpost = "Land_BagBunker_Tower_F";
FOB_box_outpost = "Land_Cargo10_grey_F";
FOB_sign = "SignAd_Sponsor_F";
fireworks_typename = "Land_CargoBox_V1_F";
Radio_tower = "Land_Communication_F";
Arsenal_typename = "B_supplyCrate_F";
Box_Weapon_typename = "Box_NATO_Wps_F";
Box_Ammo_typename = "Box_NATO_Ammo_F";
Box_Support_typename = "Box_NATO_Support_F";
Box_Launcher_typename = "Box_NATO_WpsLaunch_F";
Box_Special_typename = "Box_NATO_WpsSpecial_F";
Respawn_truck_typename = "B_Truck_01_medical_F";
ammo_truck_typename = "B_Truck_01_ammo_F";
fuel_truck_typename = "B_Truck_01_fuel_F";
repair_truck_typename = "B_Truck_01_Repair_F";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
mobile_respawn = "Land_TentDome_F";
mobile_respawn_bag = "B_Kitbag_Base";
medicalbox_typename = "Box_B_UAV_06_medical_F";
playerbox_typename = "Land_PlasticCase_01_medium_olive_CBRN_F";
playerbox_cargospace = 1500;
ammobox_b_typename = "Box_NATO_AmmoVeh_F";
ammobox_o_typename = "Box_East_AmmoVeh_F";
ammobox_i_typename = "Box_IND_AmmoVeh_F";
waterbarrel_typename = "Land_BarrelWater_F";
fuelbarrel_typename = "Land_MetalBarrel_F";
foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F";
opfor_transport_truck = "O_Truck_03_transport_F";
repair_offroad = "C_Offroad_01_repair_F";
commander_classname = "B_officer_F";
crewman_classname = "B_crew_F";
pilot_classname = "B_Helipilot_F";
PAR_Medikit = "Medikit";
PAR_AidKit = "FirstAidKit";
A3W_BoxWps = "Box_East_Wps_F";
canister_fuel_typename = "Land_CanisterFuel_Red_F";
GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F";
GRLIB_sar_fire = "test_EmptyObjectForFireBig";
civilians = ["C_man_1"];
civilian_vehicles = ["C_SUV_01_F"];
SHOP_Man = "C_Man_formal_1_F";
SELL_Man = "C_Story_Mechanic_01_F";
uavs = [];
boats_west = [];
opfor_boats = [];
vehicle_big_units = [];
GRLIB_vehicle_whitelist = [];
GRLIB_vehicle_blacklist = [];
opfor_texture_overide = [];
opfor_statics = [];
units_loadout_overide = [];
list_static_weapons = [];
static_vehicles_AI = [];

// *** LRX DEFAULT SUPPORT CLASSNAMES ***
support_vehicles = [
	[Arsenal_typename,0,35,0,0]
];

if (!GRLIB_enable_arsenal) then {
	Arsenal_typename = Box_Ammo_typename;
	support_vehicles = [
		[Box_Ammo_typename,0,0,0,0],
		[Box_Weapon_typename,0,180,0,0],
		[Box_Support_typename,0,250,0,GRLIB_perm_inf],
		[Box_Launcher_typename,0,300,0,GRLIB_perm_log],
		[Box_Special_typename,0,325,0,GRLIB_perm_tank]
	];
};

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
default_support_vehicles = support_vehicles + [
	[medicalbox_typename,5,25,0,0],
	[mobile_respawn,10,50,0,0],
	[canister_fuel_typename,0,25,10,0],
	[playerbox_typename,0,0,0,20],
	[Respawn_truck_typename,15,150,5,GRLIB_perm_log],
	["Land_RepairDepot_01_civ_F",10,300,0,GRLIB_perm_log],
	["Land_MedicalTent_01_MTP_closed_F",5,150,0,GRLIB_perm_log],
	[repair_sling_typename,10,300,0,GRLIB_perm_log],
	[fuel_sling_typename,0,150,60,GRLIB_perm_log],
	[ammo_sling_typename,0,600,0,GRLIB_perm_log],
	[medic_sling_typename,0,150,0,GRLIB_perm_log],
	[ammo_truck_typename,5,600,10,GRLIB_perm_tank],
	[repair_truck_typename,0,300,30,GRLIB_perm_tank],
	[fuel_truck_typename,5,150,70,GRLIB_perm_tank],
	[FOB_box_outpost,5,500,20,GRLIB_perm_log],
	[FOB_box_typename,10,1500,40,GRLIB_perm_max],
	[FOB_truck_typename,50,1500,50,GRLIB_perm_max],
	[fireworks_typename,0,500,0,GRLIB_perm_max],
	[ammobox_b_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_o_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_i_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[A3W_BoxWps,0,round(150 / GRLIB_recycling_percentage),0,99999],
	[waterbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,99999],
	[fuelbarrel_typename,0,round(60 / GRLIB_recycling_percentage),30,99999],
	[foodbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,99999]
];

// *** LRX DEFAULT BUILDINGS CLASSNAMES ***
buildings_default = [
	["Land_PierLadder_F",0,0,0,GRLIB_perm_inf],
	["Land_CncBarrierMedium4_F",0,0,0,0],
	["Land_CncWall4_F",0,0,0,0],
	["Land_BagFence_Round_F",0,0,0,GRLIB_perm_log],
	["Land_BagFence_Long_F",0,0,0,0],
	["Land_BagFence_Short_F",0,0,0,GRLIB_perm_inf],
	["Land_BagFence_Corner_F",0,0,0,GRLIB_perm_log],
	["Land_RampConcrete_F",0,0,0,GRLIB_perm_log],
	["Land_RampConcreteHigh_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrier_5_F",0,0,0,0],
	["Land_HBarrierWall_corridor_F",0,0,0,0],
	["Land_HBarrierWall4_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall6_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall_corner_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierTower_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierBig_F",0,0,0,GRLIB_perm_tank],
	["Land_CncShelter_F",0,0,0,GRLIB_perm_log],
	["Land_BagBunker_Small_F",0,0,0,0],
	["Land_BagBunker_Large_F",0,0,0,GRLIB_perm_tank],
	["Land_MedicalTent_01_NATO_generic_open_F",0,0,0,GRLIB_perm_inf],
	//["Land_BagBunker_Tower_F",0,0,0,GRLIB_perm_tank],
	["Land_SandbagBarricade_01_F",0,0,0,GRLIB_perm_log],
	["Land_SandbagBarricade_01_hole_F",0,0,0,GRLIB_perm_log],
	["Land_SandbagBarricade_01_half_F",0,0,0,GRLIB_perm_log],
	["Land_SM_01_shed_F",0,0,0,GRLIB_perm_max],
	["Land_Hangar_F",0,0,0,GRLIB_perm_max],
	["Land_Medevac_house_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Medevac_HQ_V1_F",0,0,0,GRLIB_perm_air],
	["Land_PortableLight_double_F",0,0,0,GRLIB_perm_log],
	["Land_TentLamp_01_suspended_F",0,0,0,GRLIB_perm_log],
    ["Land_TentLamp_01_suspended_red_F",0,0,0,GRLIB_perm_log],
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
	["PortableHelipadLight_01_red_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_white_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_green_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_yellow_F",0,0,0,GRLIB_perm_tank],
	["Land_DieselGroundPowerUnit_01_F",0,0,0,GRLIB_perm_tank],
	["Land_Pallet_MilBoxes_F",0,0,0,GRLIB_perm_tank],
	["Land_PaperBox_open_full_F",0,0,0,GRLIB_perm_tank],
	["Land_CzechHedgehog_01_new_F",0,0,0,GRLIB_perm_inf],
	["Land_ConcreteHedgehog_01_F",0,0,0,GRLIB_perm_log],
	["Land_DragonsTeeth_01_4x2_old_redwhite_F",0,0,0,GRLIB_perm_tank],
	["Land_ClutterCutter_large_F",0,0,0,GRLIB_perm_tank]
];

// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries
box_transport_config = [
	[ "C_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "C_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "C_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "C_Van_01_box_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "C_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ]
];
box_transport_offset = [];

// Everything the AI troups should be able to resupply from
ai_resupply_sources = [
	Arsenal_typename,
	ammo_truck_typename,
	ammo_sling_typename,
	Box_Ammo_typename
];

// Everything the AI troups should be able to healing from
ai_healing_sources = [
	Respawn_truck_typename,
	medicalbox_typename,
	medic_sling_typename,
	"Land_MedicalTent_01_MTP_closed_F"
];

// Everything the AI vehicle should be able to reammo from
vehicle_rearm_sources = [
	ammo_truck_typename,
	ammo_sling_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename
];

// Everything the AI vehicle should be able to repair from
vehicle_repair_sources = [
	repair_sling_typename,
	repair_truck_typename,
	"C_Offroad_01_repair_F",
	"B_G_Offroad_01_repair_F",
	"Land_RepairDepot_01_civ_F"
];