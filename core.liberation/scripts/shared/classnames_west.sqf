// *** WEST ***

if ( isNil "huron_typename_west" ) then { huron_typename_west = "B_Heli_Transport_03_unarmed_F" };
if ( isNil "FOB_typename_west" ) then { FOB_typename_west = "Land_Cargo_HQ_V1_F" };
if ( isNil "FOB_box_typename_west" ) then { FOB_box_typename_west = "B_Slingload_01_Cargo_F" };
if ( isNil "FOB_truck_typename_west" ) then { FOB_truck_typename_west = "B_Truck_01_box_F" };
if ( isNil "Respawn_truck_typename_west" ) then { Respawn_truck_typename_west = "B_Truck_01_medical_F" };
if ( isNil "ammo_truck_typename_west" ) then { ammo_truck_typename_west = "B_Truck_01_ammo_F" };
if ( isNil "fuel_truck_typename_west" ) then { fuel_truck_typename_west = "B_Truck_01_fuel_F" };
if ( isNil "repair_truck_typename_west" ) then { repair_truck_typename_west = "B_Truck_01_Repair_F" };
if ( isNil "repair_sling_typename_west" ) then { repair_sling_typename_west = "B_Slingload_01_Repair_F" };
if ( isNil "fuel_sling_typename_west" ) then { fuel_sling_typename_west = "B_Slingload_01_Fuel_F" };
if ( isNil "ammo_sling_typename_west" ) then { ammo_sling_typename_west = "B_Slingload_01_Ammo_F" };
if ( isNil "medic_sling_typename_west" ) then { medic_sling_typename_west = "B_Slingload_01_Medevac_F" };
if ( isNil "commander_classname_west" ) then { commander_classname_west = "B_officer_F" };
if ( isNil "crewman_classname_west" ) then { crewman_classname_west = "B_crew_F" };
if ( isNil "pilot_classname_west" ) then { pilot_classname_west = "B_Helipilot_F" };

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["B_soldier_F",1,0,0,0],
	["B_medic_F",1,0,0,0],
	["B_engineer_F",1,0,0,0],
	["B_soldier_GL_F",1,0,0,GRLIB_perm_inf],
	["B_soldier_M_F",1,0,0,GRLIB_perm_inf],
	["B_soldier_LAT_F",1,0,0,0],
	["B_Sharpshooter_F",1,0,0,GRLIB_perm_inf],
	["B_HeavyGunner_F",1,0,0,GRLIB_perm_inf],
	["B_recon_F",1,0,0,GRLIB_perm_log],
	["B_recon_M_F",1,0,0,GRLIB_perm_log],
	["B_Recon_Sharpshooter_F",1,0,0,GRLIB_perm_log],
	["B_soldier_AA_F",1,0,0,GRLIB_perm_log],
	["B_soldier_AT_F",1,0,0,GRLIB_perm_log],
	["B_sniper_F",1,0,0,GRLIB_perm_log],
	["B_soldier_PG_F",1,0,0,GRLIB_perm_log],
	[crewman_classname_west,1,0,0,GRLIB_perm_inf],
	[pilot_classname_west,1,0,0,GRLIB_perm_log]
];

// calc units price
[] call compileFinal preprocessFileLineNumbers "scripts\loadouts\init_loadouts.sqf";
_grp = createGroup [west, true];
{
	_unit_class = _x select 0;
	_unit_mp = _x select 1;
	_unit_rank = _x select 4;
	_unit = _grp createUnit [_unit_class, [0,0,0], [], 0, "NONE"];
	if (typeOf _unit in units_loadout_overide) then {
		_loadouts_folder = format ["scripts\loadouts\%1\%2.sqf", west, typeOf _unit];
		[_unit] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
	};
	_price = [_unit] call F_loadoutPrice;
	infantry_units_west set [_forEachIndex, [_unit_class, _unit_mp, _price, 0,_unit_rank] ];
	deleteVehicle _unit;
} foreach infantry_units_west ;

light_vehicles_west = [
	["B_Quadbike_01_F",1,5,1,0],
	["B_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["B_Boat_Armed_01_minigun_F",5,30,5,GRLIB_perm_log],
	["B_SDV_01_F",5,30,5,GRLIB_perm_log],
	["C_Scooter_Transport_01_F",1,5,1,0],
	["SUV_01_base_black_F",1,10,1,0],
	["B_G_Offroad_01_F",1,10,1,0],
	["B_G_Offroad_01_armed_F",1,50,1,GRLIB_perm_inf],
	["C_SUV_01_F",1,10,1,GRLIB_perm_inf],
	["C_Van_01_transport_F",1,15,1,0],
	["B_MRAP_01_F",2,25,2,0],
	["B_MRAP_01_hmg_F",5,100,2,GRLIB_perm_inf],
	["B_MRAP_01_gmg_F",5,125,2,GRLIB_perm_log],
	["B_Truck_01_transport_F",5,30,5,GRLIB_perm_log],
	["B_Truck_01_covered_F",5,30,5,GRLIB_perm_log],
	["B_LSV_01_unarmed_F",2,25,2,GRLIB_perm_inf],
	["B_LSV_01_armed_F",5,100,2,GRLIB_perm_log],
	["B_UGV_01_F",5,10,5,GRLIB_perm_inf],
	["B_UGV_01_rcws_F",5,250,5,GRLIB_perm_log]
];

heavy_vehicles_west = [
	["B_APC_Tracked_01_rcws_F",10,500,10,GRLIB_perm_log],
	["B_APC_Wheeled_01_cannon_F",10,500,10,GRLIB_perm_log],
	["B_APC_Tracked_01_AA_F",10,500,10,GRLIB_perm_tank],
	["B_MBT_01_cannon_F",15,1000,15,GRLIB_perm_tank],
	["B_MBT_01_TUSK_F",15,1500,15,GRLIB_perm_air],
	["B_AFV_Wheeled_01_cannon_F",15,3000,15,GRLIB_perm_max],
	["B_AFV_Wheeled_01_up_cannon_F",15,3500,15,GRLIB_perm_max],
	["B_MBT_01_arty_F",15,3500,15,GRLIB_perm_max]
];

air_vehicles_west = [
	["B_UAV_01_F",1,10,5,GRLIB_perm_log],
	["B_UAV_06_F",1,30,5,GRLIB_perm_tank],
	["B_UAV_02_dynamicLoadout_F",5,1000,5,GRLIB_perm_air],
	["B_T_UAV_03_dynamicLoadout_F",5,1500,10,GRLIB_perm_max],
	["B_UAV_05_F",5,2000,15,GRLIB_perm_max],
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_air],
	["B_Heli_Light_01_F",1,50,5,GRLIB_perm_log],
	["B_Heli_Light_01_dynamicLoadout_F",5,200,10,GRLIB_perm_air],
	["B_Heli_Transport_03_unarmed_F",10,500,15,GRLIB_perm_tank],
	["B_Heli_Transport_03_F",10,1500,15,GRLIB_perm_air],
	["B_Heli_Transport_01_F",10,1500,15,GRLIB_perm_tank],
	["B_T_VTOL_01_infantry_F",10,1300,15,GRLIB_perm_air],
	["B_T_VTOL_01_vehicle_F",10,1400,15,GRLIB_perm_air],
	["B_T_VTOL_01_armed_F",20,2500,40,GRLIB_perm_max],
	["B_Heli_Attack_01_dynamicLoadout_F",10,3000,20,GRLIB_perm_air],
	["B_Heli_Attack_02_dynamicLoadout_F",10,4500,20,GRLIB_perm_max],
	["B_Plane_CAS_01_dynamicLoadout_F",20,3000,40,GRLIB_perm_max],
	["B_Plane_Fighter_01_F",20,4500,40,GRLIB_perm_max],
	["B_Plane_Fighter_01_Stealth_F",20,4500,40,GRLIB_perm_max]
];

blufor_air_west = [
	"B_Heli_Attack_01_F",
	"B_Plane_CAS_01_F",
	"B_Plane_Fighter_01_F",
	"B_Heli_Attack_01_F"
];

static_vehicles_west = [
	["B_UGV_02_Demining_F",0,5,0,GRLIB_perm_inf],
	["B_Static_Designator_01_F",0,5,0,GRLIB_perm_inf],
	["B_HMG_01_F",0,10,0,GRLIB_perm_log],
	["B_HMG_01_high_F",0,10,0,GRLIB_perm_tank],
	["B_GMG_01_F",0,20,0,GRLIB_perm_log],
	["B_GMG_01_high_F",0,20,0,GRLIB_perm_tank],
	["B_static_AA_F",0,50,0,GRLIB_perm_air],
	["B_static_AT_F",0,50,0,GRLIB_perm_air],
	["B_Mortar_01_F",0,500,0,GRLIB_perm_max],
	["B_AAA_System_01_F",10,500,0,GRLIB_perm_max],
	["B_Ship_Gun_01_F",10,1500,0,GRLIB_perm_max]
];

buildings_west = buildings + [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["Flag_NATO_F",0,0,0,0]
];

support_vehicles_west = [
	[Arsenal_typename,0,10,0,0],
	[medicalbox_typename,5,5,0,0],
	[mobile_respawn,10,5,0,0],
	[canisterFuel,0,5,1,0],
	["B_G_Offroad_01_repair_F",5,15,5,GRLIB_perm_inf],
	["B_G_Van_01_fuel_F",5,15,20,GRLIB_perm_inf],
	[Respawn_truck_typename_west,15,150,5,GRLIB_perm_log],
	[repair_sling_typename_west,10,100,0,GRLIB_perm_log],
	[fuel_sling_typename_west,0,100,30,GRLIB_perm_log],
	[ammo_sling_typename_west,0,150,0,GRLIB_perm_log],
	[medic_sling_typename_west,10,100,0,GRLIB_perm_log],
	[ammo_truck_typename_west,5,200,10,GRLIB_perm_tank],
	[repair_truck_typename_west,10,130,10,GRLIB_perm_tank],
	[fuel_truck_typename_west,5,120,40,GRLIB_perm_tank],
	["Box_NATO_Ammo_F",0,80,0,GRLIB_perm_log],
	["Box_NATO_WpsLaunch_F",0,150,0,GRLIB_perm_tank],
	["Land_CargoBox_V1_F",0,500,0,GRLIB_perm_max],
	[FOB_box_typename_west,50,1500,50,GRLIB_perm_max],
	[FOB_truck_typename_west,50,1500,50,GRLIB_perm_max],
	["B_APC_Tracked_01_CRV_F",10,2000,20,GRLIB_perm_max],
	[ammobox_b_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_o_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_i_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[A3W_BoxWps,0,round(150 / GRLIB_recycling_percentage),0,99999],
	[waterbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[fuelbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[foodbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_Soldier_GL_F",
	"B_soldier_AR_F",
	"B_Soldier_F",
	"B_Soldier_F"
	];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_M_F",
	"B_Soldier_AR_F",
	"B_HeavyGunner_F",
	"B_Sharpshooter_F"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_AT_F",
	"B_soldier_AT_F",
	"B_soldier_F",
	"B_soldier_F"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_AA_F",
	"B_soldier_AA_F",
	"B_soldier_F",
	"B_soldier_F"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_AA_F",
	"B_soldier_AT_F",
	"B_soldier_F",
	"B_soldier_F"
	];
};
if ( isNil "blufor_squad_recon" ) then { blufor_squad_recon = [] };
if ( count blufor_squad_recon == 0 ) then { blufor_squad_recon = [
	"B_recon_TL_F",
	"B_recon_medic_F",
	"B_Recon_Sharpshooter_F",
	"B_recon_LAT_F",
	"B_recon_M_F",
	"B_recon_F"
	];
};

squads_west = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_recon,25,500,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs_west = [
	"B_UAV_01_F",
	"B_UAV_02_dynamicLoadout_F",
	"B_T_UAV_03_F",
	"B_UAV_05_F",
	"B_UAV_06_F",
	"C_UAV_06_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F"
];
