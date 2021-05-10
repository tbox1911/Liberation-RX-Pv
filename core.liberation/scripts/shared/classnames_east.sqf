// *** EAST ***

if ( isNil "huron_typename_east" ) then { huron_typename_east = "O_Heli_Transport_04_black_F" };
if ( isNil "FOB_typename_east" ) then { FOB_typename_east = "Land_Cargo_HQ_V3_F" };
if ( isNil "FOB_box_typename_east" ) then { FOB_box_typename_east = "Land_Pod_Heli_Transport_04_box_black_F" };
if ( isNil "FOB_truck_typename_east" ) then { FOB_truck_typename_east = "O_T_Truck_03_device_ghex_F" };
if ( isNil "Respawn_truck_typename_east" ) then { Respawn_truck_typename_east = "O_Truck_03_medical_F" };
if ( isNil "ammo_truck_typename_east" ) then { ammo_truck_typename_east = "O_Truck_03_ammo_F" };
if ( isNil "fuel_truck_typename_east" ) then { fuel_truck_typename_east = "O_Truck_03_fuel_F" };
if ( isNil "repair_truck_typename_east" ) then { repair_truck_typename_east = "O_Truck_03_Repair_F" };
if ( isNil "repair_sling_typename_east" ) then { repair_sling_typename_east = "Land_Pod_Heli_Transport_04_repair_F" };
if ( isNil "fuel_sling_typename_east" ) then { fuel_sling_typename_east = "Land_Pod_Heli_Transport_04_fuel_F" };
if ( isNil "ammo_sling_typename_east" ) then { ammo_sling_typename_east = "Land_Pod_Heli_Transport_04_ammo_F" };
if ( isNil "medic_sling_typename_east" ) then { medic_sling_typename_east = "Land_Pod_Heli_Transport_04_medevac_F" };
if ( isNil "commander_classname_east" ) then { commander_classname_east = "O_officer_F" };
if ( isNil "crewman_classname_east" ) then { crewman_classname_east = "O_crew_F" };
if ( isNil "pilot_classname_east" ) then { pilot_classname_east = "O_Helipilot_F" };

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_east = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["O_soldier_F",1,0,0,0],
	["O_medic_F",1,0,0,0],
	["O_engineer_F",1,0,0,0],
	["O_soldier_GL_F",1,0,0,GRLIB_perm_inf],
	["O_soldier_M_F",1,0,0,GRLIB_perm_inf],
	["O_soldier_LAT_F",1,0,0,0],
	["O_Sharpshooter_F",1,0,0,GRLIB_perm_inf],
	["O_HeavyGunner_F",1,0,0,GRLIB_perm_inf],
	["O_recon_F",1,0,0,GRLIB_perm_log],
	["O_recon_M_F",1,0,0,GRLIB_perm_log],
	["O_soldier_AA_F",1,0,0,GRLIB_perm_log],
	["O_soldier_AT_F",1,0,0,GRLIB_perm_log],
	["O_sniper_F",1,0,0,GRLIB_perm_log],
	["O_soldier_PG_F",1,0,0,GRLIB_perm_log],
	[crewman_classname_east,1,0,0,GRLIB_perm_inf],
	[pilot_classname_east,1,0,0,GRLIB_perm_log]
];

// calc units price
[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";
private _grp = createGroup [east, true];
{
	private _unit_class = _x select 0;
	private _unit_mp = _x select 1;
	private _unit_rank = _x select 4;
	private _unit = _grp createUnit [_unit_class, [0,0,0], [], 0, "NONE"];
	if (typeOf _unit in units_loadout_overide) then {
		_loadouts_folder = format ["scripts\loadouts\%1\%2.sqf", east, typeOf _unit];
		[_unit] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
	};
	private _price = [_unit] call F_loadoutPrice;
	infantry_units_east set [_forEachIndex, [_unit_class, _unit_mp, _price, 0,_unit_rank] ];
	deleteVehicle _unit;
} foreach infantry_units_east;

light_vehicles_east = [
	["O_Quadbike_01_F",1,5,1,0],
	["O_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["O_T_Boat_Armed_01_hmg_F",5,30,5,GRLIB_perm_log],
	["B_SDV_01_F",5,30,5,GRLIB_perm_log],
	["C_Scooter_Transport_01_F",1,5,1,0],
	["SUV_01_base_black_F",1,10,1,0],
	["O_G_Offroad_01_F",1,10,1,0],
	["O_G_Offroad_01_armed_F",1,50,1,GRLIB_perm_inf],
	["C_SUV_01_F",1,10,1,GRLIB_perm_inf],
	["C_Van_01_transport_F",1,15,1,0],
	["O_MRAP_02_F",2,25,2,0],
	["O_MRAP_02_hmg_F",5,100,2,GRLIB_perm_inf],
	["O_MRAP_02_gmg_F",5,125,2,GRLIB_perm_log],
	["O_Truck_02_transport_F",5,10,5,GRLIB_perm_inf],
	["O_Truck_03_transport_F",5,50,5,GRLIB_perm_log],
	["O_Truck_02_covered_F",5,10,5,GRLIB_perm_inf],
	["O_Truck_03_covered_F",5,50,5,GRLIB_perm_log],
	["O_LSV_02_unarmed_F",2,25,2,GRLIB_perm_inf],
	["O_LSV_02_armed_F",5,100,2,GRLIB_perm_log],
	["O_UGV_01_F",5,10,5,GRLIB_perm_inf],
	["O_UGV_01_rcws_F",5,250,5,GRLIB_perm_log]
];

heavy_vehicles_east = [
	["O_APC_Wheeled_02_rcws_v2_F",10,400,10,GRLIB_perm_log],
	["O_APC_Tracked_02_cannon_F",10,800,10,GRLIB_perm_log],
	["O_APC_Tracked_02_AA_F",10,1500,10,GRLIB_perm_tank],
	["O_MBT_02_cannon_F",15,1500,15,GRLIB_perm_tank],
	["O_MBT_04_cannon_F",15,2500,15,GRLIB_perm_air],
	["O_MBT_04_command_F",15,2500,15,GRLIB_perm_air],
	["O_MBT_02_arty_F",15,3500,15,GRLIB_perm_max]
];

air_vehicles_east = [
	["O_UAV_01_F",1,10,5,GRLIB_perm_log],
	["O_UAV_06_F",1,30,5,GRLIB_perm_tank],
	["O_UAV_02_dynamicLoadout_F",5,1000,5,GRLIB_perm_air],
	["O_T_UAV_04_CAS_F",5,1500,10,GRLIB_perm_max],
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_air],
	["O_Heli_Light_02_unarmed_F",1,250,5,GRLIB_perm_tank],
	["O_Heli_Transport_04_F",3,500,10,GRLIB_perm_air],
	["O_Heli_Light_02_dynamicLoadout_F",5,1000,10,GRLIB_perm_air],
	["O_Heli_Attack_02_dynamicLoadout_F",10,2000,20,GRLIB_perm_air],
	//["O_T_VTOL_02_infantry_dynamicLoadout_F", 10,2500,20,GRLIB_perm_max],
	//["O_T_VTOL_02_vehicle_dynamicLoadout_F", 10,2500,20,GRLIB_perm_max],
	["O_Plane_CAS_02_dynamicLoadout_F",20,4000,40,GRLIB_perm_max],
	["O_Plane_Fighter_02_F",20,4500,40,GRLIB_perm_max],
	["O_Plane_Fighter_02_Stealth_F",20,4500,40,GRLIB_perm_max]
];

air_attack_east = [
	"O_Heli_Light_02_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_F",
	"O_T_VTOL_02_infantry_dynamicLoadout_F",
	"O_Plane_CAS_02_dynamicLoadout_F",
	"O_Plane_Fighter_02_F",
	"O_Plane_Fighter_02_Stealth_F"
];

static_vehicles_east = [
	["O_UGV_02_Demining_F",0,5,0,GRLIB_perm_inf],
	["O_HMG_01_F",0,10,0,GRLIB_perm_log],
	["O_HMG_01_high_F",0,10,0,GRLIB_perm_tank],
	["O_GMG_01_F",0,20,0,GRLIB_perm_log],
	["O_GMG_01_high_F",0,20,0,GRLIB_perm_tank],
	["O_static_AA_F",0,50,0,GRLIB_perm_air],
	["O_static_AT_F",0,50,0,GRLIB_perm_air],
	["O_Mortar_01_F",0,500,0,GRLIB_perm_max],
	["B_AAA_System_01_F",10,500,0,GRLIB_perm_max],
	["O_SAM_System_04_F",10,500,0,GRLIB_perm_max]
];

buildings_custom_east = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["Flag_CSAT_F",0,0,0,0]
];

buildings_east = buildings + buildings_custom_east;

support_vehicles_east = [
	[Arsenal_typename,0,10,0,0],
	[medicalbox_typename,5,5,0,0],
	[mobile_respawn,10,5,0,0],
	[canisterFuel,0,5,1,0],
	["O_G_Offroad_01_repair_F",5,15,5,GRLIB_perm_inf],
	["O_G_Van_01_fuel_F",5,15,20,GRLIB_perm_inf],
	[Respawn_truck_typename_east,15,150,5,GRLIB_perm_log],
	["Land_Pod_Heli_Transport_04_bench_F",0,50,0,GRLIB_perm_log],
	["Land_Pod_Heli_Transport_04_covered_F",0,50,0,GRLIB_perm_log],
	[repair_sling_typename_east,10,100,0,GRLIB_perm_log],
	[fuel_sling_typename_east,0,100,30,GRLIB_perm_log],
	[ammo_sling_typename_east,0,150,0,GRLIB_perm_log],
	[medic_sling_typename_east,10,100,0,GRLIB_perm_log],
	[ammo_truck_typename_east,5,200,10,GRLIB_perm_tank],
	[repair_truck_typename_east,10,130,10,GRLIB_perm_tank],
	[fuel_truck_typename_east,5,120,40,GRLIB_perm_tank],
	["Box_NATO_WpsLaunch_F",0,150,0,GRLIB_perm_tank],
	["Land_CargoBox_V1_F",0,500,0,GRLIB_perm_max],
	[FOB_box_typename_east,50,1500,50,GRLIB_perm_max],
	[FOB_truck_typename_east,50,1500,50,GRLIB_perm_max],
	[ammobox_b_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_o_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_i_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[A3W_BoxWps,0,round(150 / GRLIB_recycling_percentage),0,99999],
	[waterbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[fuelbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[foodbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf]
];

if ( isNil "opfor_squad_inf_light" ) then { opfor_squad_inf_light = [] };
if ( count opfor_squad_inf_light == 0 ) then { opfor_squad_inf_light = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_Soldier_GL_F",
	"O_soldier_AR_F",
	"O_Soldier_F",
	"O_Soldier_F"
	];
};
if ( isNil "opfor_squad_inf" ) then { opfor_squad_inf = [] };
if ( count opfor_squad_inf == 0 ) then { opfor_squad_inf = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_M_F",
	"O_Soldier_AR_F",
	"O_HeavyGunner_F",
	"O_Sharpshooter_F"
	];
};
if ( isNil "opfor_squad_at" ) then { opfor_squad_at = [] };
if ( count opfor_squad_at == 0 ) then { opfor_squad_at = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_AT_F",
	"O_soldier_AT_F",
	"O_soldier_F",
	"O_soldier_F"
	];
};
if ( isNil "opfor_squad_aa" ) then { opfor_squad_aa = [] };
if ( count opfor_squad_aa == 0 ) then { opfor_squad_aa = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_AA_F",
	"O_soldier_AA_F",
	"O_soldier_F",
	"O_soldier_F"
	];
};
if ( isNil "opfor_squad_mix" ) then { opfor_squad_mix = [] };
if ( count opfor_squad_mix == 0 ) then { opfor_squad_mix = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_AA_F",
	"O_soldier_AT_F",
	"O_soldier_F",
	"O_soldier_F"
	];
};
if ( isNil "opfor_squad_recon" ) then { opfor_squad_recon = [] };
if ( count opfor_squad_recon == 0 ) then { opfor_squad_recon = [
	"O_recon_TL_F",
	"O_recon_medic_F",
	"O_recon_F",
	"O_recon_LAT_F",
	"O_recon_M_F",
	"O_recon_F"
	];
};

squads_east = [
	[opfor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[opfor_squad_inf,20,400,0,GRLIB_perm_max],
	[opfor_squad_recon,25,500,0,GRLIB_perm_max],
	[opfor_squad_at,25,600,0,GRLIB_perm_max],
	[opfor_squad_aa,25,600,0,GRLIB_perm_max],
	[opfor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs_east = [
	"O_UAV_01_F",
	"O_UAV_06_F",
	"O_UAV_02_dynamicLoadout_F",
	"O_T_UAV_04_CAS_F",
	"O_UGV_01_F",
	"O_UGV_01_rcws_F",
	"O_UGV_02_Demining_F"
];
